import { CallData, hash, Account, cairo } from "starknet";

import { buildEddsa, buildPoseidon } from "circomlibjs";

import {
  toBigIntBE,
  randomBytes,
  findClaimLocation,
  base64ToAscii,
  asciiCodesToString,
} from "./compute";

import { OZaccountClassHash } from "../config/walletConfig";

import { MAX_ISS_BYTES } from "../config/const";

import { IContractAddress } from "./type";

import { checkWalletDeploy } from "@/http";

/**
   * 生成指定长度的随机数，并将其转换为十六进制字符串格式的大整数表示
   * 该函数使用 randomBytes 函数生成具有指定长度（默认为 16）的随机字节数组，然后
   * 利用 toBigIntBE 函数将其转换为大整数，并最终转换为字符串形式返回

  * @param length {number} - 随机数的长度，默认为 16
  * @returns {string} 生成的随机数的字符串形式，以十六进制表示的大整数
 */
export function generateRandomness(length = 16) {
  return String(toBigIntBE(randomBytes(length)));
}

/**
 * 生成一个随机数（Nonce）
 * 这个函数是非同步的，它使用了 WebCrypto API 来生成随机字节数组，然后使用这些字节数组来计算一个 Nonce。
 * Nonce 是通过对用户的公钥（publicKey）、用户提供的随机性（randomness）字符串以及期望的过期时间（exp）字符串进行 Poseidon 哈希计算得出的。
 * @param publicKey {string} - 用户的公钥，将被转换为一个大整数（BigInt）
 * @param randomness {string} - 用户提供的随机性字符串，用于增加 Nonce 的随机性
 * @param exp {number} - 期望的过期时间字符串，用于增加 Nonce 的唯一性
 * @returns {string} 生成的 Nonce 的字符串表示，它是通过将 Nonce 转换为 BigInt，然后转换为字符串得到的
 * @throws 如果浏览器不支持 WebCrypto API 或者没有可用的随机数生成器，将抛出错误信息 "crypto.getRandomValues must be defined"
 */
export async function generateNonce(publicKey: string, randomness: string, exp: string) {
  const eddsa = await buildEddsa();
  const F = eddsa.babyJub.F;
  const poseidon = await buildPoseidon();
  const p = BigInt(publicKey);
  const nonce = poseidon([p.toString(), randomness, exp]);
  const data = F.toObject(nonce).toString();
  return data;
}

export async function getContractAddress({
  provider,
  privateKey,
  salt,
  jwtToken,
  exp,
  jwtClaim,
}: IContractAddress) {
  const { issVersion } = jwtClaim;
  try {
    // 验证JWT Token格式
    if (!jwtToken.includes(".")) {
      throw new Error("Invalid JWT Token format");
    }
    const [header, payload, signature] = jwtToken.split(".");

    const decodedPayload = JSON.parse(atob(payload as string));

    const data = {
      jwt: `${header}.${payload}`,
      sig: signature,
      iss: decodedPayload.iss,
      sub: decodedPayload.sub,
      aud: decodedPayload.aud,
      nonce: decodedPayload.nonce,
      exp,
    };

    let iss_result = base64ToAscii(issVersion, 32);

    let subascii = asciiCodesToString(data.sub);

    let poseidon = await buildPoseidon();
    let eddsa = await buildEddsa();
    const F = eddsa.babyJub.F;
    let sub_hash = F.toObject(poseidon([subascii, salt]));

    let param_data = {
      iss1: cairo.uint256(iss_result.firstPartAscii),
      iss2: cairo.uint256(iss_result.secondPartAscii),
      sub: cairo.uint256(sub_hash),
    };

    let param = CallData.compile(param_data);

    let pub_hash = hash.computeHashOnElements(param);
    let OZaccountConstructorCallData = CallData.compile({ publicKey: pub_hash });

    const OZcontractAddress = hash.calculateContractAddressFromHash(
      pub_hash,
      OZaccountClassHash,
      OZaccountConstructorCallData,
      0,
    );

    const OZaccount = new Account(provider, OZcontractAddress, privateKey);

    return {
      sub: param_data.sub,
      pub_hash,
      OZaccount,
      OZcontractAddress,
      OZaccountConstructorCallData,
    };
  } catch (error) {
    console.error("Error in getContractAddress:", error);
    throw error; // 重新抛出异常以保持一致性
  }
}

export async function generateAccountAddress({
  provider,
  privateKey,
  exp,
  jwtToken,
  salt,
  jwtClaim,
}: IContractAddress) {
  // 计算钱包地址
  const { OZaccount, OZcontractAddress, OZaccountConstructorCallData, pub_hash, sub } =
    await getContractAddress({
      provider,
      privateKey,
      jwtToken,
      exp,
      salt,
      jwtClaim,
    });

  // 检查钱包是否部署
  const res = await checkWalletDeploy(OZcontractAddress);

  return {
    isDeploy: res?.code === 0,
    sub,
    pub_hash,
    OZaccount,
    OZcontractAddress,
    OZaccountConstructorCallData,
  };
}
