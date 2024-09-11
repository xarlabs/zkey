import { IUserInfo } from "@/components/ZkLoginProvider/types";

export interface IGoogleLoginProps {
  clientId: string;
  loadingContent?: React.ReactNode | (() => React.ReactNode);
  userContent: React.ReactNode | ((userInfo: IUserInfo) => React.ReactNode);
}
