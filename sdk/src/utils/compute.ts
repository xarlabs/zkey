/*
 * @Author: 汪培良 dk264874293@gmail.com
 * @Date: 2024-09-09 17:40:24
 * @LastEditors: 汪培良 dk264874293@gmail.com
 * @LastEditTime: 2024-10-11 10:14:57
 * @FilePath: /sdk/src/utils/compute.ts
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import { CIRCOM_BIGINT_N, CIRCOM_BIGINT_K } from "../config/const";
import { IFindClaimRes } from "./type.d";
const textEncoder = new TextEncoder();
const CryptoJS = require("crypto");

export function isBytes(a: any): boolean {
  return (
    a instanceof Uint8Array ||
    (a != null && typeof a === "object" && a.constructor.name === "Uint8Array")
  );
}

export function bytesToHex(bytes: any) {
  if (!isBytes(bytes)) {
    throw new Error("Uint8Array expected");
  }
  const hexes = Array.from({ length: 256 }, (_, i) => i.toString(16).padStart(2, "0"));
  // pre-caching improves the speed 6x
  let hex = "";
  for (let i = 0; i < bytes.length; i++) {
    hex += hexes[bytes[i]];
  }
  return hex;
}
/**
 * 将任意类型的数据转换为大整数，使用大端字节序
 *
 * @param bytes 任意类型的数据
 * @return 转换后的大整数
 */

export function toBigIntBE(bytes: any) {
  const hex = bytesToHex(bytes);
  if (hex.length === 0) {
    return BigInt(0);
  }
  return BigInt(`0x${hex}`);
}

const int64toBytes = (num: number) => {
  const arr = new ArrayBuffer(8); // an Int32 takes 4 bytes
  const view = new DataView(arr);
  view.setInt32(4, num, false); // byteOffset = 0; litteEndian = false
  return new Uint8Array(arr);
};

export const mergeUInt8Arrays = (a1: Uint8Array, a2: Uint8Array): Uint8Array => {
  // 检查输入参数的有效性
  if (!a1 || !a2) {
    throw new Error("Input arrays must not be null or undefined");
  }

  // 使用 const 来声明变量
  const mergedArray = new Uint8Array(a1.length + a2.length);
  mergedArray.set(a1);
  mergedArray.set(a2, a1.length);

  return mergedArray;
};

export const int8toBytes = (num: number) => {
  const arr = new ArrayBuffer(1);
  const view = new DataView(arr);
  view.setUint8(0, num);

  return new Uint8Array(arr);
};

export const toByteArray = (str: any) => {
  try {
    return textEncoder.encode(str);
  } catch (error) {
    console.error("Failed to encode string:", error);
    throw error;
  }
};
/**
 * 生成指定长度的随机字节数组
 *
 * @param bytesLength - 要生成的随机字节数组的长度，默认为 32 字节
 * @throws 当 window.crypto.getRandomValues 方法未定义时抛出错误
 * @return 生成的随机字节数组
 */
export function randomBytes(bytesLength = 32) {
  if (window.crypto && typeof window.crypto.getRandomValues === "function") {
    return window.crypto.getRandomValues(new Uint8Array(bytesLength));
  }
  throw new Error("crypto.getRandomValues must be defined");
}

export const toCircomBigIntBytes = (num: any) => {
  const res = [];
  const bigintNum = typeof num == "bigint" ? num : num.valueOf();
  const msk = (1n << BigInt(CIRCOM_BIGINT_N)) - 1n;

  for (let i = 0; i < CIRCOM_BIGINT_K; ++i) {
    res.push(((bigintNum >> BigInt(i * CIRCOM_BIGINT_N)) & msk).toString());
  }

  return res;
};

/**
 * 对给定的预哈希消息进行填充，以满足SHA-256哈希算法的要求
 * 此函数用于准备消息，使其长度符合SHA-256块大小的倍数，并处理消息长度超出最大哈希字节数的情况
 *
 * @param prehash_prepad_m 预哈希处理后的消息，为一个Uint8Array类型的字节数组
 * @param maxShaBytes 允许的最大哈希字节数，用于限制填充后消息的长度
 * @returns 返回一个Promise，解析为包含填充后消息的Uint8Array和原始消息长度的元组
 *
 * @throws 当maxShaBytes不足以容纳填充后的消息时，抛出错误
 */
export const sha256Pad = async (
  prehash_prepad_m: Uint8Array,
  maxShaBytes: number,
): Promise<[Uint8Array, number]> => {
  const length_bits = prehash_prepad_m.length * 8; // bytes to bits
  const length_in_bytes = int64toBytes(length_bits);

  prehash_prepad_m = mergeUInt8Arrays(prehash_prepad_m, int8toBytes(2 ** 7));
  while ((prehash_prepad_m.length * 8 + length_in_bytes.length * 8) % 512 !== 0) {
    prehash_prepad_m = mergeUInt8Arrays(prehash_prepad_m, int8toBytes(0));
  }
  prehash_prepad_m = mergeUInt8Arrays(prehash_prepad_m, length_in_bytes);

  const messageLen = prehash_prepad_m.length;
  while (prehash_prepad_m.length < maxShaBytes) {
    prehash_prepad_m = mergeUInt8Arrays(prehash_prepad_m, int64toBytes(0));
  }

  return [prehash_prepad_m, messageLen];
};

/**
 * 将Uint8Array转换为字符数组
 * 此函数接收一个Uint8Array作为输入，并将其每个元素转换为字符串
 * 该转换对于调试或日志记录目的，或者当需要将二进制数据以文本形式显示时非常有用
 *
 * @param a Uint8Array，包含要转换的数据
 * @returns 字符数组，每个元素是输入Uint8Array中对应元素的字符串表示
 */
export const Uint8ArrayToCharArray = (a: Uint8Array): string[] => {
  // 确保每个元素都在 ASCII 范围内
  return Array.from(a).map((x) => x.toString());
};

export const splitJWT = (jwt: any) => {
  const result = [];
  let i = 0;

  while (jwt.length) {
    i++;
    const chunk = jwt.splice(0, 16);
    result.push(chunk);
  }

  return result;
};

export const shortNum = (bigNum: any) => {
  const num = Number(bigNum);
  if (num < 10000) {
    return num;
  } else if (num > 10000 && num < 1000000) {
    return Math.floor(num / 1000) + "K";
  } else {
    return Math.floor(num / 1000000) + "M";
  }
};

//qty: bigint, decimals: number     formatBalance:string
export const formatBalance = (qty: any, decimals: any) => {
  const balance = String("0").repeat(decimals) + qty.toString();
  const rightCleaned = balance.slice(-decimals).replace(/(\d)0+$/gm, "$1");
  const leftCleaned = BigInt(balance.slice(0, balance.length - decimals)).toString();
  return leftCleaned + "." + rightCleaned;
};

export function base64ToAscii(base64String: any, length: number) {
  try {
    console.log("base64String", base64String);
    // Base64解码
    let decodedString = atob(base64String);

    // 检查length的有效性
    if (length <= 0) {
      throw new Error("Invalid length");
    }

    // 判断第一个和第二个字符是否为冒号或引号
    let startIndex = 0;
    if (decodedString[0] === ":" || decodedString[0] === '"') {
      startIndex = 1;
      if (decodedString[1] === ":" || decodedString[1] === '"') {
        startIndex = 2;
      }
    }

    // 从指定位置提取前length个字符
    decodedString = decodedString.substring(startIndex, startIndex + length);

    // 不足长度时补NULL
    while (decodedString.length < length) {
      decodedString += "\0";
    }

    // 分成前一半和后一半字符
    const halfLength = Math.floor(length / 2);
    let firstPart = decodedString.substring(0, halfLength);
    let secondPart = decodedString.substring(halfLength, length);

    // 转为ASCII码并拼接成三位数字
    function asciiToTripleDigits(str: string) {
      let asciiArray = [];
      for (let i = 0; i < str.length; i++) {
        let asciiCode = str.charCodeAt(i).toString().padStart(3, "0");
        asciiArray.push(asciiCode);
      }
      return "200" + asciiArray.join("");
    }

    let firstPartAscii = asciiToTripleDigits(firstPart);
    let secondPartAscii = asciiToTripleDigits(secondPart);

    return {
      firstPartAscii,
      secondPartAscii,
    };
  } catch (error) {
    console.error("Error in base64ToAscii:", error);
    throw error;
  }
}

export function asciiCodesToString(s: any) {
  let result = "";
  for (let i = 0; i < s.length; i++) {
    // 获取当前字符的Unicode码点
    let code = s.charCodeAt(i);
    // 将码点转换为字符串（即其十进制表示）
    let codeStr = code.toString();
    // 将转换后的字符串拼接到结果字符串中
    result += codeStr;
  }
  return result;
}

export const findClaimLocation = (jwt: any, claim: any, max: any): IFindClaimRes => {
  let clean_test = btoa(claim).replaceAll("=", ""); //0
  let quote_at_0_index = btoa(`"${claim}`).replaceAll("=", ""); //1
  let colon_at_0_index = btoa(`:${claim}`).replaceAll("=", ""); //1
  let quote_and_colon_at_start = btoa(`":${claim}`).replaceAll("=", ""); //2
  let colon_and_quote_at_start = btoa(`:"${claim}`).replaceAll("=", ""); //2
  let comma_at_the_end = btoa(`${claim},`).replaceAll("=", ""); //0
  let quote_at_start_and_end = btoa(`"${claim}"`).replaceAll("=", ""); //1
  let quote_and_comma_at_end = btoa(`${claim}",`).replaceAll("=", ""); //0
  let comma_and_quote_at_end = btoa(`${claim},"`).replaceAll("=", ""); //0
  let colon_at_start_and_comma_at_end = btoa(`:${claim},`).replaceAll("=", ""); //1
  let colon_and_quote_at_start_quote_at_end = btoa(`:"${claim}"`).replaceAll("=", ""); //2
  const versions: string[] = [
    clean_test,
    quote_at_0_index,
    colon_at_0_index,
    quote_and_colon_at_start,
    colon_and_quote_at_start,
    comma_at_the_end,
    quote_at_start_and_end,
    quote_and_comma_at_end,
    comma_and_quote_at_end,
    colon_at_start_and_comma_at_end,
    colon_and_quote_at_start_quote_at_end,
  ];

  let claimLocation;
  let version: string = "";

  // 遍历这些编码形式，并在 JWT 中查找这些编码形式的存在位置
  for (let i = 0; i < versions.length; i++) {
    if (jwt.indexOf(versions[i]) !== -1) {
      claimLocation = jwt.indexOf(versions[i]);
      version = versions[i] as string;

      break;
    }
  }

  // 将找到的位置的字节与声明的字节逐个比较，确保找到的确实是声明的位置
  let claimBytes: Uint8Array | number[] = toByteArray(version);

  const len = claimBytes.length;
  if (len <= max) {
    // 如果声明的字节数组长度小于最大长度，则用 0 填充
    claimBytes = [...claimBytes, ...new Array(Math.max(max - len, 0)).fill(0)];
  } else {
    // 如果声明的字节数组长度大于最大长度，则截取前面的字节
    claimBytes = Array.from(claimBytes.slice(0, max));
  }

  //表示claim声明的字节数组，经过 Base64 编码和填充到最大长度。它是一个字符串数组，每个元素表示一个字节
  return {
    claim: [claimBytes.map((v) => v.toString()), claimLocation],
    version,
  };
};

export const shaHash = (str) => {
  return CryptoJS.createHash("sha256").update(str).digest();
};

export const uint8ToBits = (uint8) => {
  return uint8.reduce((acc, byte) => acc + byte.toString(2).padStart(8, "0"), "");
};

export const genID = (length = 16): string => {
  return Number(Math.random().toString().substr(3, length) + Date.now()).toString(36);
};
