export interface IWalletProviderProps {
  children: React.ReactNode;
  currencyAddress?: string[];
}

export type TWalletEvent = "deploy" | "transfer" | "resetPub";
export interface ITransferProps {
  // 事件状态
  state: "pending" | "running" | "success" | "error";
  id: string;
  event?: TWalletEvent;
  message?: string;
  amount?: number;
  toAddress?: string;
}
