"use client";
import React, { useEffect, useState, useMemo, useCallback } from "react";
import { Contract, num, shortString, CallData, cairo } from "starknet";
import Big from "big.js";
import { WalletStateContext, WalletDispatcherContext } from "./Provider";
export { useWalletState, useWalletDispatcher } from "./Provider";
import { useZkState, useZkDispatcher } from "@/components/ZkLoginProvider";
import { handleLocalStorage, StorageEnum } from "@/utils/storage";
import { u256toWeb, setWalletDeploy, checkZKeyLogin, walletResetPub } from "@/utils/wallet";
import { SEPOLIA_DEF_CONTRACT_ADDRESS, GAS_ADDRESS } from "@/config/walletConfig";
import { IWalletProviderProps } from "./type";
import tokenApiJson from "@/config/tokenApi";
import { WALLET_V3_ADDRESS, OZaccountClassHash } from "@/config/walletConfig";
import { getWalletPrices, checkWalletDeploy } from "@/http";
import walletAbi from "@/config/walletAbi";

const WalletProvider = (props: IWalletProviderProps) => {
  const { children, currencyAddress } = props;
  const { globalAccount, globalL3Account, provider, isDeploy, walletDetail } = useZkState();

  const { handleChangeDeploy, handleUserLogOut } = useZkDispatcher();

  const [walletLoading, setWalletLoading] = useState<boolean>(false);

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
      const { callData } = walletDetail;
      if (!isDeploy) {
        const res = await checkWalletDeploy(transferAccount.address);
        const checkDeploy = res?.code === 0;
        if (!checkDeploy) {
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
        const { suggestedMaxFee: estimatedFee1 } = await transferAccount.estimateInvokeFee({
          contractAddress: activeWallet.address,
          entrypoint: "transfer",
          calldata: CallData.compile({
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
  const handleTransfer = async (amount: number, toAddress: string) => {
    // 计算预估的总费用是否超过余额
    // 支付gas的账户是否为前钱执行转账的钱包
    const isactiveGasPrice = activeWallet.address === activeGasAddress.address;
    // 钱包余额
    const TotalNum = new Big(activeGasBalance.balance);
    // 需要支付的
    const TotalGasBalance = isactiveGasPrice
      ? new Big(amount).plus(new Big(gasFree))
      : new Big(gasFree);

    if (!TotalNum.gte(TotalGasBalance)) {
      throw new Error("Insufficient funds to pay fee");
    }

    const { input, jwtLength, callData, address, pub_hash, exp, publicKey } = walletDetail;
    setTransferLoading(true);
    if (!isDeploy) {
      setTransferStateText("Checking Address");
      const res = await checkWalletDeploy(address);
      const checkDeploy = res?.code === 0;
      if (!checkDeploy) {
        setTransferStateText("Deploying Account");
        try {
          await setWalletDeploy({
            callData,
            pub_hash,
            provider: provider,
            account: transferAccount,
          });
          const res = await checkWalletDeploy(address);
          const isDeploy = res?.code === 0;
          handleChangeDeploy(isDeploy);
          handleLocalStorage(
            "set",
            StorageEnum.WALLET_DETAIL,
            JSON.stringify({ ...walletDetail, isDeploy }),
          );
        } catch (error) {
          setTransferStateText("");
          setTransferLoading(false);
          if (error?.message?.indexOf("exceeds balance")) {
            throw new Error("Insufficient funds to pay fee");
          } else {
            throw new Error("Network error Please try again later");
          }
        }
      }
    }
    try {
      const acountObj = new Contract(walletAbi.abi, address, provider);
      const bal1 = await acountObj.get_public_key();

      // 如果公钥不匹配则重设公司钥对
      if (publicKey !== num.toHexString(bal1)) {
        const dateNow = new Date().getTime() / 1000;
        // 判断是否过期
        const isNotExpired = exp && Number(exp) - dateNow > 30;
        if (isNotExpired) {
          setTransferStateText("Getting Zero Knowledge Proof");
          const proof = await checkZKeyLogin(input, jwtLength);
          setTransferStateText("Setting Session Key");

          try {
            await walletResetPub({
              account: transferAccount,
              provider: provider,
              accountAddress: address,
              proof,
            });
          } catch (error) {
            setTransferStateText("");
            setTransferLoading(false);
            console.log("error", error);
            if (error?.message?.indexOf("exceeds balance")) {
              throw new Error("Insufficient funds to pay fee");
            } else {
              throw new Error("Network error Please try again later");
            }
          }
        } else {
          setTransferLoading(false);
          setTimeout(() => {
            handleUserLogOut();
          }, [3000]);
          throw new Error("Sorry, you have timed out and are about to log out");
        }
      }
      try {
        // 链接钱包
        const linkContract = new Contract(tokenApiJson.abi, activeWallet?.address, transferAccount);
        setTransferStateText("Executing Transaction");
        // 转账
        const respTransfer = await linkContract.transfer(
          toAddress,
          BigInt(amount * 10 ** 18).toString(),
        );
        // 执行
        await provider.waitForTransaction(respTransfer.transaction_hash);

        handleWalletBalance(activeWallet?.address);
        setTransferLoading(false);
      } catch (error) {
        console.log("error -->", error);
        setTransferLoading(false);
        throw new Error("Transfer failure Please check the entered information");
      }
    } catch (error) {
      setTransferLoading(false);
      throw error;
    }
  };

  useEffect(() => {
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

    if (globalAccount?.address) {
      getAccountBalance();
    }
  }, [queryContractData, globalAccount?.address]);

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
