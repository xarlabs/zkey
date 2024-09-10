/*
 * @Author: 汪培良 dk264874293@gmail.com
 * @Date: 2024-09-09 17:24:32
 * @LastEditors: 汪培良 dk264874293@gmail.com
 * @LastEditTime: 2024-09-09 17:27:30
 * @FilePath: /sdk/src/utils/type.d.ts
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import { ProviderInterface, ProviderOptions } from "starknet";
export interface ICreateInputsData {
  jwt: string;
  sig: string | undefined;
  iss: any;
  sub: any;
  aud: any;
  nonce: any;
  name: any;
  picture: any;
  email: any;
  given_name: any;
  family_name: any;
}

export interface ICreateInputsWalletOpt {
  salt: string;
  publicKey: string;
  randomness: string;
  exp: string;
}

export interface IContractAddress {
  provider: ProviderInterface | ProviderOptions;
  privateKey: string;
  salt: string;
  jwtToken: string;
  exp: string;
}
