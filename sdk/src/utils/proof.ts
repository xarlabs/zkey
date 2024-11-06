import {
  toCircomBigIntBytes,
  sha256Pad,
  Uint8ArrayToCharArray,
  findClaimLocation,
  splitJWT,
  shaHash,
  uint8ToBits,
} from "./compute";
import { ICreateInputsData, ICreateInputsWalletOpt } from "./type.d";
import {
  MAX_MSG_PADDED_BYTES,
  MAX_ISS_BYTES,
  MAX_SUB_BYTES,
  MAX_AUD_BYTES,
  MAX_NONCE_BYTES,
} from "../config/const";
import { getPubkey } from "@/http/index";
const Buffer = require("buffer/").Buffer;
// 解析 jwt 数据

const PART_SEPARATOR = ".";

/**
 * 解析JWT令牌并返回其相关数据
 * @param token JWT令牌字符串
 * @returns 返回包含JWT头、负载以及签名的结构化数据如果令牌格式无效，则抛出错误
 *
 * 此函数旨在对JWT(Javascript Web Token)进行解析，提取其中包含的信息
 * 它首先将令牌字符串按部分分隔符分开，然后解码负载部分，最后返回一个包含
 * 原始JWT结构、签名以及一些特定声明的数据对象如果令牌格式不符合预期，
 * 则捕获错误并抛出
 */
export const getJWTData = (token: string): ICreateInputsData => {
  try {
    // 使用PART_SEPARATOR分隔令牌字符串为三个部分：头(header)、负载(payload)和签名(signature)
    const [header, payload, signature] = token.split(PART_SEPARATOR);

    // 检查payload是否存在，确保令牌至少包含头和负载部分
    if (!payload) {
      throw new Error("Invalid JWT token format");
    }

    // 解码payload部分，将其转换为可读的JSON对象
    const decodedPayload = JSON.parse(atob(payload));

    // 构建返回数据对象，包括原始JWT结构、签名以及从负载中提取的特定声明
    const data = {
      jwt: `${header}${PART_SEPARATOR}${payload}`, // 原始JWT结构(头和负载)
      sig: signature, // 签名部分
      iss: decodedPayload.iss || undefined, // 发行者
      sub: decodedPayload.sub || undefined, // 主题
      aud: decodedPayload.aud || undefined, // 受众
      nonce: decodedPayload.nonce || undefined, // 随机数
      name: decodedPayload.name || undefined, // 名称
      picture: decodedPayload.picture || undefined, // 头像URL
      email: decodedPayload.email || undefined, // 邮箱
      given_name: decodedPayload.given_name || undefined, // 名
      family_name: decodedPayload.family_name || undefined, // 姓
    };

    return data;
  } catch (error) {
    // 捕获并记录解析JWT令牌时发生的错误
    console.error("Error parsing JWT token:", error);
    throw error;
  }
};

export const findJwtClaim = (data: ICreateInputsData) => {
  const { claim: issClaim, version: issVersion } = findClaimLocation(
    data.jwt,
    data.iss,
    MAX_ISS_BYTES,
  );
  const { claim: subClaim, version: subVersion } = findClaimLocation(
    data.jwt,
    data.sub,
    MAX_SUB_BYTES,
  );
  const { claim: audClaim, version: audVersion } = findClaimLocation(
    data.jwt,
    data.aud,
    MAX_AUD_BYTES,
  );
  const { claim: nonceClaim, version: nonceVersion } = findClaimLocation(
    data.jwt,
    data.nonce,
    MAX_NONCE_BYTES,
  );
  return {
    issClaim,
    issVersion,
    subClaim,
    subVersion,
    audClaim,
    audVersion,
    nonceClaim,
    nonceVersion,
  };
};

export const createNewInputs = async (data, walletOpt, jwtClaim, public_key) => {
  const msg = data.jwt;
  const sig = data.sig;
  const { salt, publicKey, randomness, exp } = walletOpt;
  const signature = toCircomBigIntBytes(BigInt(`0x${Buffer.from(sig, "base64").toString("hex")}`));
  const [jwtPadded, _] = await sha256Pad(new TextEncoder().encode(msg), MAX_MSG_PADDED_BYTES);
  const jwt = await Uint8ArrayToCharArray(jwtPadded);
  const jwt_sha256 = uint8ToBits(shaHash(new TextEncoder().encode(msg)));

  const { issClaim, subClaim, audClaim, nonceClaim } = jwtClaim;
  // const rsaPubkey = toCircomBigIntBytes(await getPubkey(data.jwt));
  let rsaPubkey;
  if (public_key) {
    rsaPubkey = toCircomBigIntBytes(BigInt(public_key));
  } else {
    // const response = await getPubkey(data.jwt);
    // console.log("response --->", response.data);
    // rsaPubkey = response.code === 0 ? toCircomBigIntBytes(BigInt(response.data)) : "";
    // console.log("rsaPubkey -->", rsaPubkey);
    console.log("jwt -->", data.jwt);
    const pubKeyData = await getPubkey(data.jwt);
    console.log("pubKeyData -->", pubKeyData);
    rsaPubkey = toCircomBigIntBytes(BigInt(pubKeyData));
    console.log("rsaPubkey -->", rsaPubkey);
    // console.log("rsaPubkey -->", rsaPubkey);
  }

  const inputs = {
    jwt_segments: splitJWT(jwt),
    jwt_sha256: jwt_sha256.split(""),
    iss: issClaim[0],
    iss_loc: issClaim[1],
    sub: subClaim[0],
    sub_loc: subClaim[1],
    aud: audClaim[0],
    aud_loc: audClaim[1],
    nonce: nonceClaim[0],
    nonce_loc: nonceClaim[1],
    exp,
    pubkey: BigInt(publicKey).toString(),
    randomness,
    salt,
    signature,
    modulus: rsaPubkey,
  };

  console.log("inputs -->", inputs);

  return {
    inputs,
    jwtLength: msg.length,
  };
};

// export const createInputs = async (
//   data: ICreateInputsData,
//   walletOpt: ICreateInputsWalletOpt,
//   jwtClaim,
//   public_key,
// ) => {
//   let { jwt: msg, sig } = data;
//   const { salt, publicKey, randomness, exp } = walletOpt;
//   const { issClaim, subClaim, audClaim, nonceClaim } = jwtClaim;
//   const signature = toCircomBigIntBytes(BigInt(`0x${Buffer.from(sig, "base64").toString("hex")}`));
//   const [jwtPadded, jwtPaddedLen] = await sha256Pad(
//     new TextEncoder().encode(msg),
//     MAX_MSG_PADDED_BYTES,
//   );
//   const jwt_padded_bytes = jwtPaddedLen.toString();
//   const jwt = await Uint8ArrayToCharArray(jwtPadded);

//   let rsaPubkey;
//   if (public_key) {
//     rsaPubkey = toCircomBigIntBytes(BigInt(public_key));
//   } else {
//     const response = await getPubkey(data.jwt);
//     rsaPubkey = response.code === 0 ? toCircomBigIntBytes(BigInt(response.data)) : "";
//     const pubKeyData = await getPubkey(data.jwt);
//     rsaPubkey = toCircomBigIntBytes(pubKeyData);
//     console.log("rsaPubkey -->", rsaPubkey);
//   }

//   const inputs = {
//     jwt_segments: splitJWT(jwt),
//     jwt_padded_bytes,
//     iss: issClaim[0],
//     iss_loc: issClaim[1],
//     sub: subClaim[0],
//     sub_loc: subClaim[1],
//     aud: audClaim[0],
//     aud_loc: audClaim[1],
//     nonce: nonceClaim[0],
//     nonce_loc: nonceClaim[1],
//     exp,
//     //   exp_loc: expClaim[1],
//     pubkey: BigInt(publicKey).toString(),
//     randomness,
//     salt,
//     signature,
//     modulus: rsaPubkey,
//   };

//   console.log("inputs -->", inputs);

//   return inputs;
// };
