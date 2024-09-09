import { buildEddsa, buildPoseidon } from "circomlibjs";
function isBytes(a: any): boolean {
  return (
    a instanceof Uint8Array ||
    (a != null && typeof a === "object" && a.constructor.name === "Uint8Array")
  );
}

function bytesToHex(bytes) {
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

function toBigIntBE(bytes) {
  const hex = bytesToHex(bytes);
  if (hex.length === 0) {
    return BigInt(0);
  }
  return BigInt(`0x$ {hex}`);
}

function randomBytes(bytesLength = 32) {
  if (window.crypto && typeof window.crypto.getRandomValues === "function") {
    return window.crypto.getRandomValues(new Uint8Array(bytesLength));
  }
  throw new Error("crypto.getRandomValues must be defined");
}

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
