"use client";
import React, { useState, useRef, useEffect, useMemo, useCallback } from "react";
import {
  stark,
  RpcProvider,
  ec,
  Account,
  Contract,
  num,
  constants,
  AccountInterface,
} from "starknet";
import { ZkStateContext, ZkDispatcherContext } from "./Provider";
export { useZkState, useZkDispatcher, useZkContext } from "./Provider";
import { IZkLoginProviderProps, IUserInfo, IWalletConfig, IWalletDetail, IZkState } from "./types";
import { handleLocalStorage, StorageEnum } from "@/utils/storage";
import { nodeUrl } from "../../config/walletConfig";
import { generateRandomness, generateNonce, generateAccountAddress } from "@/utils/wallet";
import { getJWTData, createInputs } from "@/utils/proof";
import walletAbi from "@/config/walletAbi.json";
import { getSalt } from "@/http";

const ZKeyLoginProvider = (props: IZkLoginProviderProps) => {
  const { children, handleLogOutCallback, handleLogInCallback } = props;
  // rpc 实例
  const provider = useRef(new RpcProvider({ nodeUrl }));
  // 登录loading
  const [loginLoading, setLoginLoading] = useState<boolean>(false);
  // 登录阶段文本
  const [loadingContent, setLoadingContent] = useState<string>("");
  // 用户信息
  const [userInfo, setUserInfo] = useState<IUserInfo | null>(null);
  // 初始化钱包参数
  const [walletConfig, setWalletConfig] = useState<IWalletConfig | null>(null);
  // 钱包是否部署
  const [isDeploy, setIsDeploy] = useState<boolean>(false);
  // 钱包详情
  const [walletDetail, setWalletDetail] = useState<IWalletDetail | null>(null);
  // 账号实例
  const [globalAccount, setGlobalAccount] = useState<AccountInterface | null>(null);
  // L3账号实例 通过STRK作为gas交易
  const [globalL3Account, setGlobalL3Account] = useState<AccountInterface | null>(null);

  const handleLogIn = useCallback(
    async (jwtToken: string) => {
      const { publicKey, randomness, exp, privateKey } = (walletConfig as IWalletConfig) || {};
      setLoginLoading(true);
      setLoadingContent("Getting Salt");
      let salt = "";
      // 获取salt
      try {
        const res = await getSalt(jwtToken);
        salt = res.data;
      } catch (error) {
        console.log("error", error);
        setLoginLoading(false);
        throw new Error("get Salt error");
      }
      // 解析jwt
      const jwtData = getJWTData(jwtToken);
      // 解析加密数据
      const input = await createInputs(jwtData, {
        salt,
        publicKey,
        randomness,
        exp,
      });

      setLoadingContent("Calculating Address");

      // 创建钱包
      const {
        OZaccount,
        OZcontractAddress,
        OZaccountConstructorCallData,
        sub,
        pub_hash,
        isDeploy,
      } = await generateAccountAddress({
        privateKey,
        provider: provider.current,
        jwtToken: jwtToken,
        exp,
        salt,
      });

      // L3 实例
      const userL3Account = new Account(
        provider.current,
        OZcontractAddress,
        privateKey,
        undefined,
        constants.TRANSACTION_VERSION.V3,
      );

      // 组装钱包数据
      const walletOptions: IWalletDetail = {
        privateKey,
        publicKey,
        address: OZcontractAddress,
        callData: OZaccountConstructorCallData,
        salt: salt,
        input,
        pub_hash,
        sub,
        exp,
        isDeploy,
      };

      console.log("jwtData", jwtData);
      const { name, picture, email, given_name, family_name } = jwtData;
      const userInfo = { name, picture, email, given_name, family_name };

      handleLocalStorage("set", StorageEnum["USER_INFO"], JSON.stringify(userInfo));
      handleLocalStorage("set", StorageEnum.WALLET_DETAIL, JSON.stringify(walletOptions));
      // 存储钱包数据
      setWalletDetail(walletOptions);
      setIsDeploy(isDeploy);
      setGlobalAccount(OZaccount);
      setGlobalL3Account(userL3Account);

      setUserInfo(userInfo);
      setLoadingContent("");
      setLoginLoading(false);
      handleLogInCallback && handleLogInCallback(userInfo);
    },
    [walletConfig],
  );

  // 退出登录清除所有状态
  const handleUserLogOut = useCallback(() => {
    setWalletDetail(null);
    setUserInfo(null);
    handleLocalStorage("remove", StorageEnum.WALLET_DETAIL);
    handleLocalStorage("remove", StorageEnum.USER_INFO);
    handleLogOutCallback && handleLogOutCallback();
  }, [handleLogOutCallback]);
  // const [wallet]
  useEffect(() => {
    const getNonce = async () => {
      // 随机生成的私钥
      const privateKey = stark.randomAddress();
      // 对应的公钥
      const publicKey = ec.starkCurve.getStarkKey(privateKey);
      // 随机种子
      const randomness = generateRandomness();
      const dateNow = new Date().getTime();
      // 过期时间24小时
      const exp = Math.trunc((dateNow + 1000 * 60 * 60 * 24) / 1000).toString();
      // 生成nonce
      const nonce = await generateNonce(publicKey, randomness, exp);
      setWalletConfig({
        privateKey,
        publicKey,
        randomness,
        exp,
        nonce,
      });
    };
    const walletInit = async () => {
      // 获取本地存储的数据
      const storageWalletDetail: boolean | string | undefined = handleLocalStorage(
        "get",
        StorageEnum.WALLET_DETAIL,
      );
      const storageUserInfo: boolean | string | undefined = handleLocalStorage(
        "get",
        StorageEnum.USER_INFO,
      );
      if (storageWalletDetail && storageUserInfo) {
        try {
          const walletDetailParse: IWalletDetail = JSON.parse(storageWalletDetail);
          const userInfoParse: IUserInfo = JSON.parse(storageUserInfo);

          const { privateKey, address, isDeploy, publicKey, exp } = walletDetailParse;

          const userAccount = new Account(provider.current, address, privateKey);

          const userL3Account = new Account(
            provider.current,
            address,
            privateKey,
            undefined,
            constants.TRANSACTION_VERSION.V3,
          );

          const dateNow = new Date().getTime() / 1000;
          const isNotExpired = !!(exp && Number(exp) - dateNow > 60 * 10);
          // 设置数据
          const setWalletInitData = () => {
            setWalletDetail(walletDetailParse);
            setGlobalAccount(userAccount);
            setGlobalL3Account(userL3Account);
            setIsDeploy(isDeploy);
            setUserInfo({ ...userInfoParse });
            handleLogInCallback && handleLogInCallback(userInfoParse);
          };
          if (isNotExpired) {
            setWalletInitData();
            return;
          }

          if (isDeploy) {
            const accountContract = new Contract(walletAbi.abi, address, provider.current);
            const contractPublicKey = await accountContract.get_public_key();
            if (publicKey === num.toHexString(contractPublicKey)) {
              setWalletInitData();
              return;
            }
          }
          handleUserLogOut();
          getNonce();
        } catch (error) {
          handleUserLogOut();
          getNonce();
        }
      } else {
        getNonce();
      }
    };
    walletInit();
  }, []);

  const zkState: IZkState = useMemo(
    () => ({
      userInfo,
    }),
    [userInfo],
  );
  const zkDispatcher = useMemo(() => {}, []);

  return (
    <ZkStateContext.Provider value={zkState}>
      <ZkDispatcherContext.Provider value={zkDispatcher}>{children}</ZkDispatcherContext.Provider>
    </ZkStateContext.Provider>
  );
};

export default ZKeyLoginProvider;
