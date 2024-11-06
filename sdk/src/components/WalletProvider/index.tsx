"use client";
import React, { useEffect, useState, useMemo, useCallback } from "react";
import { Contract, num, shortString, CallData, cairo } from "starknet";
import Big from "big.js";
import { WalletStateContext, WalletDispatcherContext } from "./Provider";
export { useWalletState, useWalletDispatcher } from "./Provider";
import { useZkPrivate, useZkState, useZkDispatcher } from "@/components/ZkLoginProvider";
import { handleLocalStorage, StorageEnum } from "@/utils/storage";
import {
  u256toWeb,
  checkZKeyLogin,
  walletResetTransfer,
  checkWalletDeploy,
  newWalletResetPub,
} from "@/utils/wallet";
import {
  SEPOLIA_DEF_CONTRACT_ADDRESS,
  GAS_ADDRESS,
  WALLET_V3_ADDRESS,
  OZaccountClassHash,
} from "@/config/walletConfig";
import { IWalletProviderProps, TWalletEvent, ITransferProps } from "./type";
import tokenApiJson from "@/config/tokenApi";
import { getWalletPrices, setOutsideDeploy, getOutsideExecute } from "@/http";
import walletAbi from "@/config/walletAbi";
import { genID } from "@/utils/compute";
const WalletProvider = (props: IWalletProviderProps) => {
  const { children, currencyAddress } = props;
  const { rpcPubKey } = useZkPrivate();
  const { globalAccount, globalL3Account, provider, isDeploy, walletDetail } = useZkState();

  const { handleChangeDeploy, handleUserLogOut } = useZkDispatcher();

  const [walletLoading, setWalletLoading] = useState<boolean>(false);

  const [transferList, setTransferList] = useState<ITransferProps[]>([]);

  const [transferLoading, setTransferLoading] = useState<boolean>(false);

  const [transferStateText, setTransferStateText] = useState<string>("");

  const [currencyList, setCurrencyList] = useState([]);

  const [activeContract, handleChangeActiveContract] = useState<string>("");

  const [activeGasAddress, handleChangActiveGasAddress] = useState<string>("");

  const [gasLoading, setGasLoading] = useState<boolean>(false);

  const [gasFree, setGasFree] = useState<string | number>("-");

  const [amount, setAmount] = useState<number>(0);

  const activeWallet = useMemo(() => {
    const findIndex = currencyList.findIndex((item) => item.address === activeContract);
    return findIndex !== -1 ? currencyList[findIndex] : null;
  }, [activeContract, currencyList]);

  const transferAccount = useMemo(() => {
    return WALLET_V3_ADDRESS.includes(activeGasAddress?.address) ? globalL3Account : globalAccount;
  }, [activeGasAddress, globalL3Account, globalAccount]);

  const activeGasBalance = useMemo(() => {
    return currencyList.find((item) => item.address === activeGasAddress?.address);
  }, [currencyList, activeGasAddress?.balance]);

  const activeGasPrice = useMemo(() => {
    if (typeof gasFree === "number" && gasFree > 0) {
      const min = new Big(0.001);
      const num = new Big(gasFree).times(activeGasBalance?.prices);
      return num.gte(min) ? num.toNumber().toFixed(3) : 0;
    }
    return "-";
  }, [gasFree, activeGasBalance]);

  const totalPrice = useMemo(() => {
    if (amount && activeGasPrice) {
      if (activeGasPrice === "-") return "-";
      let balance = new Big(amount).times(new Big(activeWallet?.prices));
      balance = balance.plus(new Big(activeGasPrice));
      return balance.toString();
    }
    return "-";
  }, [amount, activeWallet?.prices, activeGasPrice]);

  const overallBalance = useMemo(() => {
    let overallBalance = new Big(0);
    for (let index = 0; index < currencyList.length; index++) {
      if (currencyList[index]["sum"]) {
        overallBalance = overallBalance.plus(new Big(currencyList[index]["sum"]));
      }
    }
    return overallBalance.toNumber();
  }, [currencyList]);

  const queryContractData = useCallback(
    (address: string) =>
      new Promise(async (resolve, reject) => {
        try {
          let newContract = new Contract(tokenApiJson.abi, address, provider);
          const [pricesRes, balanceRes, walletNameRes] = await Promise.allSettled([
            getWalletPrices(address),
            newContract.balanceOf(globalAccount?.address),
            newContract.symbol(),
          ]);
          newContract["prices"] =
            pricesRes.status === "fulfilled"
              ? pricesRes.value.length > 0
                ? pricesRes.value[pricesRes.value.length - 1]["value"]
                : 0
              : 0;

          newContract["balance"] =
            balanceRes.status === "fulfilled" ? u256toWeb(balanceRes.value) : ""; //  shortString.decodeShortString(num.toHex(Number(balance)))
          newContract["walletName"] =
            walletNameRes.status === "fulfilled"
              ? shortString.decodeShortString(num.toHexString(walletNameRes.value))
              : "";

          newContract["sum"] = new Big(newContract["balance"])
            .times(new Big(newContract["prices"]))
            .toNumber();
          resolve(newContract);
        } catch (error) {
          console.log("queryContractData", error);
          reject(error);
        }
      }),
    [globalAccount, provider],
  );

  // 添加币种
  const handleAddCurrency = useCallback(
    async (address) => {
      try {
        const findCurrentIndex = currencyList.findIndex((item) => item.address === address);
        if (findCurrentIndex > -1) {
          //   Toast.show({
          //     icon: "fail",
          //     content: "The currency has been added",
          //   });
          throw new Error("The currency has been added");
        } else {
          const getContract = await queryContractData(address);
          setCurrencyList((state) => [...state, getContract]);
        }
      } catch (error) {
        throw error;
      }
    },
    [currencyList, queryContractData],
  );

  // 重新查询余额
  const handleWalletBalance = useCallback(
    async (address: string) => {
      const newCurrencyList = [...currencyList];
      const activeIndex = newCurrencyList.findIndex((item) => item.address === address);
      if (activeIndex !== -1) {
        const getNewContract = await queryContractData(address);
        newCurrencyList[activeIndex] = getNewContract;

        setCurrencyList(newCurrencyList);
      }
    },
    [currencyList, globalAccount?.address],
  );

  // 查询gasfree
  const handleGetGasFree = useCallback(
    async (amount: number, toAddress: string) => {
      setAmount(amount);
      if (!amount) {
        setGasFree("-");
        return;
      }
      setGasLoading(true);
      const { callData, callDataParams } = walletDetail;
      if (!isDeploy) {
        const res = await checkWalletDeploy({ accountAddress: transferAccount.address, provider });
        // const checkDeploy = res?.code === 0;
        if (!res) {
          try {
            const { suggestedMaxFee: estimatedFee1 } =
              await transferAccount?.estimateAccountDeployFee({
                classHash: OZaccountClassHash,
                constructorCalldata: callData,
                contractAddress: transferAccount.address,
              });
            setGasFree(u256toWeb((estimatedFee1 * 12n) / 10n));
            setGasLoading(false);
          } catch (error) {
            setGasFree("-");
            setGasLoading(false);
          }
          return;
        }
      }
      try {
        const { aud1, aud2 } = callDataParams || {};
        const { suggestedMaxFee: estimatedFee1 } = await transferAccount.estimateInvokeFee({
          contractAddress: activeWallet.address,
          entrypoint: "transfer",
          calldata: CallData.compile({
            a: aud1.low,
            b: aud1.high,
            c: aud2.low,
            d: aud2.high,
            e: 0x1,
            receiption: toAddress,
            amount: cairo.uint256(amount * 10 ** 18),
          }),
        });
        setGasFree(u256toWeb((estimatedFee1 * 11n) / 10n));
      } catch (error) {
        console.log("getGasFree error --->", error);
        setGasFree("-");
      }
      setGasLoading(false);
    },
    [isDeploy, transferAccount, walletDetail, activeWallet],
  );

  // deploy 逻辑
  const handleWalletDeploy = async (
    transferData: ITransferProps,
    deployChangeCallback: (eventState: ITransferProps) => void,
  ) => {
    const checkDeploy = await checkWalletDeploy({
      accountAddress: transferAccount.address,
      provider,
    });
    if (!checkDeploy) {
      deployChangeCallback({
        ...transferData,
        state: "running",
        message: "Deploying Account",
      });
      const { pub_hash, input, jwtLength, address } = walletDetail;
      try {
        console.time("setOutsideDeploy");
        const [deployRes, proofRes] = await Promise.allSettled([
          await setOutsideDeploy(pub_hash),
          await checkZKeyLogin(rpcPubKey, input, jwtLength),
        ]);
        console.timeEnd("setOutsideDeploy");
        console.log("deployRes -->", deployRes);
        console.log("proofRes -->", proofRes);
        if (deployRes.status === "fulfilled" && deployRes.value.code === 0) {
          const { transaction_hash } = deployRes.value.data;
          console.time("waitForTransaction");
          await provider.waitForTransaction(transaction_hash);
          console.timeEnd("waitForTransaction");
          deployChangeCallback({
            ...transferData,
            state: "success",
            message: "Deploying Success",
          });
          const isDeploy = await checkWalletDeploy({
            accountAddress: transferAccount.address,
            provider,
          });
          // 重设deploy状态
          handleChangeDeploy(isDeploy);
          handleLocalStorage(
            "set",
            StorageEnum.WALLET_DETAIL,
            JSON.stringify({ ...walletDetail, isDeploy }),
          );
          deployChangeCallback({
            ...transferData,
            state: "running",
            message: "Setting Session Key",
          });
          try {
            const stringified = await newWalletResetPub({
              account: transferAccount,
              provider: provider,
              accountAddress: address,
              proof: proofRes.value,
            });
            console.time("resExecute");
            const resExecute = await getOutsideExecute(stringified);
            console.timeEnd("resExecute");
            const { transaction_hash } = resExecute.data;
            console.time("resExecute waitForTransaction");
            await provider.waitForTransaction(transaction_hash);
            console.timeEnd("resExecute waitForTransaction");

            deployChangeCallback({
              ...transferData,
              state: "success",
              message: "Setting Session Key Success",
            });
          } catch (error) {
            console.log("walletResetPub error -->", error);
            deployChangeCallback({
              ...transferData,
              state: "error",
              message: error?.message?.indexOf("exceeds balance")
                ? "Insufficient funds to pay fee"
                : "Network error Please try again later",
            });
          }
        }
      } catch (error) {
        deployChangeCallback({
          ...transferData,
          state: "error",
          message: error?.message?.indexOf("exceeds balance")
            ? "Insufficient funds to pay fee"
            : "Network error Please try again later",
        });
      }
    }
  };

  const handleWalletTransfer = async (
    transferData: ITransferProps,
    deployChangeCallback: (eventState: ITransferProps) => void,
  ) => {
    const { input, jwtLength, address, exp, publicKey, callDataParams } = walletDetail;
    const { aud1, aud2 } = callDataParams || {};
    const accountObj = new Contract(walletAbi.abi, address, provider);
    deployChangeCallback({
      ...transferData,
      state: "running",
      message: "check publicKey",
      event: "resetPub",
    });

    const accountPublicKey = await accountObj.get_public_key([
      aud1.low,
      aud1.high,
      aud2.low,
      aud2.high,
      "0x1",
    ]);
    // 查看是否需要重设公私钥
    if (publicKey !== num.toHexString(accountPublicKey)) {
      const dateNow = new Date().getTime() / 1000;
      // 判断是否过期
      const isNotExpired = exp && Number(exp) - dateNow > 30;
      if (isNotExpired) {
        deployChangeCallback({
          ...transferData,
          state: "running",
          message: "Getting Zero Knowledge Proof",
        });
        // return;
        const proof = await checkZKeyLogin(rpcPubKey, input, jwtLength);
        console.log("proof", proof);
        try {
          const stringified = await newWalletResetPub({
            account: transferAccount,
            provider: provider,
            accountAddress: address,
            proof: proof,
          });
          console.time("resExecute");
          const resExecute = await getOutsideExecute(stringified);
          console.timeEnd("resExecute");
          const { transaction_hash } = resExecute.data;
          console.time("resExecute waitForTransaction");
          await provider.waitForTransaction(transaction_hash);
          console.timeEnd("resExecute waitForTransaction");

          deployChangeCallback({
            ...transferData,
            state: "success",
            message: "Setting Session Key Success",
          });
        } catch (error) {
          console.log("walletResetPub error -->", error);
          deployChangeCallback({
            ...transferData,
            state: "error",
            message: error?.message?.indexOf("exceeds balance")
              ? "Insufficient funds to pay fee"
              : "Network error Please try again later",
          });
          return;
        }
      } else {
        // 失效登出
        deployChangeCallback({
          ...transferData,
          state: "error",
          message: "Sorry, you have timed out and are about to log out",
        });
        setTimeout(() => {
          setTransferList([]);
          handleUserLogOut();
        }, [5000]);
        return;
      }
    }
    try {
      // console.log("callDataParams", callDataParams);
      deployChangeCallback({
        ...transferData,
        state: "running",
        message: "Executing Transaction",
        event: "transfer",
      });
      const { amount, toAddress } = transferData;
      await walletResetTransfer({
        account: transferAccount,
        accountAddress: activeContract,
        provider: provider,
        toAddress: toAddress,
        callDataParams,
        amount: BigInt(amount * 10 ** 18).toString(),
      });
      deployChangeCallback({
        ...transferData,
        state: "success",
        message: "Transaction Success",
      });
      handleWalletBalance(activeWallet?.address);
    } catch (error) {
      console.log("Transaction error -->", error);
      deployChangeCallback({
        ...transferData,
        state: "error",
        message: "Transfer failure Please check the entered information",
      });
    }
  };

  const eventRemove = (id: string) => {
    setTransferList((state) => state.filter((item) => item.id !== id));
  };
  const eventEndDis = (eventList: ITransferProps[], id: string) => {
    const newTransList = eventList.filter((item) => item.id !== id);
    eventManage(newTransList);
    setTimeout(() => {
      eventRemove(id);
    }, 5000);
  };
  // 事件执行中心
  const eventManage = async (eventList: ITransferProps[]) => {
    if (eventList.length > 0) {
      for (const eventActive of eventList) {
        // 如果有没有执行完成的任务 跳出循环
        if (eventActive.state === "running") break;
        if (eventActive.state === "pending") {
          const changeCallback = (eventState) => {
            const findIndex = eventList.findIndex((item) => item.id === eventActive.id);
            eventList[findIndex] = eventState;
            if (eventState.state === "success" || eventState.state === "error") {
              eventEndDis(eventList, eventState.id);
            }
            setTransferList([...eventList]);
          };
          switch (eventActive.event) {
            case "deploy":
              handleWalletDeploy(eventActive, changeCallback);
              break;
            case "transfer":
              handleWalletTransfer(eventActive, changeCallback);
              break;
          }
          break;
        }
      }
    }
  };
  // 事件分发
  const eventTrigger = async (event: TWalletEvent, data?: any) => {
    const transferData: ITransferProps = {
      id: genID(),
      state: "pending",
    };
    switch (event) {
      // 处理deploy 事件
      case "deploy":
        transferData.message = "waiting deploying";
        transferData.event = "deploy";
        break;
      case "transfer":
        const { amount, toAddress } = data || {};
        transferData.message = "waiting transferring";
        transferData.event = "transfer";
        transferData.amount = amount;
        transferData.toAddress = toAddress;
        break;
      default:
        break;
    }
    setTransferList((state) => {
      if (!state.map((_) => _.id).includes(transferData.id)) {
        const newList = [...state, transferData];
        console.log("newList", newList);
        eventManage(newList);
        return newList;
      } else {
        return state;
      }
    });
  };

  const handleTransfer = (amount: number, toAddress: string) => {
    eventTrigger("transfer", {
      amount,
      toAddress,
    });
  };

  useEffect(() => {
    let isFirst = false;
    const getAccountBalance = async () => {
      setWalletLoading(true);
      let addressList = currencyAddress || SEPOLIA_DEF_CONTRACT_ADDRESS;

      try {
        const storageContract = handleLocalStorage("get", StorageEnum.CONTRACT_OPTION);
        const addressValArr = storageContract ? JSON.parse(storageContract) : [];
        const toLowerCaseList = addressValArr ? addressValArr.map((_) => _?.toLowerCase()) : [];
        addressList = Array.from(new Set([...addressList, ...toLowerCaseList]));
      } catch (error) {
        console.log("error", error);
      }

      let queryContractList = [];

      for (let i = 0; i < addressList.length; i++) {
        queryContractList.push(queryContractData(addressList[i]));
      }

      const queryContractListRes = await Promise.allSettled(queryContractList);

      // 初始化gas地址
      let initGasAddress;
      let contractList = [];
      for (let i = 0; i < queryContractListRes.length; i++) {
        if (queryContractListRes[i].status === "fulfilled") {
          const queryContractVal = queryContractListRes[i].value;

          if (
            !initGasAddress &&
            GAS_ADDRESS.includes(queryContractVal.address) &&
            queryContractVal.balance !== 0
          ) {
            initGasAddress = queryContractVal;
          }
          contractList.push(queryContractVal);
        }
      }
      if (!initGasAddress) {
        const filterAddress = contractList.filter((item) => item.address === GAS_ADDRESS[0]);
        initGasAddress = filterAddress[0];
      }
      handleChangActiveGasAddress(initGasAddress);
      if (contractList.length > 0) {
        handleChangeActiveContract(contractList[0].address);
      }
      setCurrencyList(contractList);
      setWalletLoading(false);
    };

    if (globalAccount?.address && !isFirst) {
      isFirst = true;
      console.log("globalAccount?.address", globalAccount?.address);
      getAccountBalance();
      if (!isDeploy) {
        eventTrigger("deploy");
      }
    }
    return () => {
      isFirst = false;
    };
  }, [queryContractData, globalAccount?.address, isDeploy]);

  const walletState = useMemo(() => {
    return {
      walletLoading,
      currencyList,
      overallBalance,
      activeWallet,
      activeGasAddress,
      gasLoading,
      activeWalletGas: gasFree,
      activeGasPrice,
      totalPrice,
      transferLoading,
      transferStateText,
      transferList,
    };
  }, [
    walletLoading,
    currencyList,
    overallBalance,
    activeWallet,
    activeGasAddress,
    gasLoading,
    gasFree,
    activeGasPrice,
    totalPrice,
    transferLoading,
    transferStateText,
    transferList,
  ]);

  const walletDispatcher = useMemo(() => {
    return {
      handleChangeActiveContract,
      handleAddCurrency,
      handleWalletBalance,
      handleChangActiveGasAddress,
      handleGetGasFree,
      handleTransfer,
    };
  }, [
    handleChangeActiveContract,
    handleAddCurrency,
    handleWalletBalance,
    handleChangActiveGasAddress,
    handleGetGasFree,
    handleTransfer,
  ]);

  return (
    <WalletStateContext.Provider value={walletState}>
      <WalletDispatcherContext.Provider value={walletDispatcher}>
        {children}
      </WalletDispatcherContext.Provider>
    </WalletStateContext.Provider>
  );
};

export default WalletProvider;
