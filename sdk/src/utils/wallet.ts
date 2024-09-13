import { CallData, hash, Account, cairo, uint256, TransactionStatus } from "starknet";
import JSONbig from "json-bigint";
import { buildEddsa, buildPoseidon } from "circomlibjs";

import {
  toBigIntBE,
  randomBytes,
  base64ToAscii,
  asciiCodesToString,
  formatBalance,
  shortNum,
} from "./compute";

import { OZaccountClassHash } from "../config/walletConfig";

import { IContractAddress } from "./type";

import { checkWalletDeploy, getProve, getGarage } from "@/http";

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

export function u256toWeb(u256: any, decimals = 18) {
  const Num = formatBalance(uint256.uint256ToBN(u256), decimals);
  return shortNum(Num);
}

export async function setWalletDeploy({ callData, pub_hash, provider, account }) {
  const { transaction_hash, contract_address } = await account.deployAccount({
    classHash: OZaccountClassHash,
    constructorCalldata: callData,
    addressSalt: pub_hash,
  });
  // 执行
  await provider.waitForTransaction(transaction_hash);
}

export async function checkZKeyLogin(input: any) {
  const INPUT = JSON.stringify(input);
  let resData = null;
  let proof = "";
  try {
    const res = await getProve(INPUT);
    resData = JSONbig.parse(res);
    console.log("resData", resData);
    // let result = res.split("[").join("").split("]").join("");
    // proof = result.split(',');
  } catch (error) {
    console.log("getProve error --->>> ", error);
  }
  if (resData) {
    let { proof: resProof, witness } = resData;
    const witnessData = witness.map((_) => _.toString(10));
    console.log("witness", witnessData);
    try {
      proof = await getGarage({
        input: JSON.stringify(witnessData),
        proof: JSON.stringify(resProof),
      });
    } catch (error) {
      console.log("getGarage error --->>> ", error);
    }
  }
  return proof;
}

export async function walletResetPub({ account, provider, accountAddress, proof }) {
  const calls = proof
    .replace(/\s/g, "") // 去除空格和换行符
    .slice(1, -1) // 去掉数组的方括号
    .split(",") // 按逗号分割字符串
    .map((num) => num.trim()); // 去掉每个数字周围的空白字符

  const calls_data = {
    contractAddress: accountAddress,
    entrypoint: "zk_set_public_key",
    calldata: CallData.compile({
      prefix: "0x535441524b4e45545f434f4e54524143545f41444452455353",
      account_hash: OZaccountClassHash,
      calls,
    }),
  };

  const result = await account.execute(calls_data);

  // 获取当前时间
  const startTime = new Date().getTime();
  // 执行交易
  await provider.waitForTransaction(result.transaction_hash, {
    retryInterval: 1000,
    successStates: [TransactionStatus.ACCEPTED_ON_L2],
  });
  // 获取执行结束时间
  const endTime = new Date().getTime();
  // 计算执行时间
  const duration = endTime - startTime;

  console.log(`执行时间为${duration}ms`);

  return calls_data;
}
