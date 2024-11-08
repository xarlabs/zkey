/*
 * @Author: 汪培良 dk264874293@gmail.com
 * @Date: 2024-09-09 16:37:53
 * @LastEditors: 汪培良 dk264874293@gmail.com
 * @LastEditTime: 2024-10-11 14:05:18
 * @FilePath: /sdk/src/index.tsx
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AEuseZkPrivate
 */

export {
  default as ZKeyLoginProvider,
  useZkPrivate,
  useZkState,
  useZkDispatcher,
  useZkContext,
} from "./components/ZkLoginProvider";

export { default as GoogleLoginButton } from "./components/GoogleLogin";

export {
  default as WalletProvider,
  useWalletState,
  useWalletDispatcher,
} from "./components/WalletProvider";

import { MainnetName, SepoliaName } from "./config/walletConfig";
export { MainnetName, SepoliaName };
