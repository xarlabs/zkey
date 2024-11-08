/*
 * @Author: 汪培良 dk264874293@gmail.com
 * @Date: 2024-11-07 13:34:57
 * @LastEditors: 汪培良 dk264874293@gmail.com
 * @LastEditTime: 2024-11-07 18:09:39
 * @FilePath: /sdk/src/components/WalletProvider/type.ts
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
export interface IWalletProviderProps {
  children: React.ReactNode;
  currencyAddress?: string[];
  handleTransferCallBack?: (data: any) => void;
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
