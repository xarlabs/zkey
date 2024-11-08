import { AccountInterface, RpcProvider } from "starknet";

export interface IZkLoginProviderProps {
  children: React.ReactNode;
  handleLogInCallback: (userInfo: any, jwtToken: string) => void; // 登录回调
  handleLogOutCallback: () => void; // 登出回调
}

export interface IUserInfo {
  email: string;
  family_name: string;
  given_name: string;
  name: string;
  picture: string;
}

export interface IWalletConfig {
  privateKey: string;
  publicKey: string;
  randomness: string;
  exp: string;
  nonce: string;
}

export interface IWalletDetail {
  address: string;
  callData: string[];
  exp: string;
  input: any;
  isDeploy: boolean;
  privateKey: string;
  pub_hash: string;
  publicKey: string;
  salt: string;
  sub: any;
  jwtLength: number;
  callDataParams: any;
}

export interface IZkPrivate {
  nonce: string | undefined;
  handleLogIn: (jwtToken: string) => Promise<void>;
}

export interface IZkState {
  provider: null | RpcProvider;
  userInfo: IUserInfo | null;
  globalNetwork: string;
  globalAccount: AccountInterface | null;
  globalL3Account: AccountInterface | null;
  isDeploy: boolean;
  walletDetail: IWalletDetail | null;
  loadingContent: string;
}

export interface IZkDispatcher {
  handleUserLogOut: () => void;
  handleChangeDeploy: (state: boolean) => void;
}
