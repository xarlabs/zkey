import { AccountInterface } from "starknet";

export interface IZkLoginProviderProps {
  children: React.ReactNode;
  handleLogInCallback: (userInfo: any) => void; // 登录回调
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
}

export interface IZkState {
  userInfo: IUserInfo | null;
}
