const {writeFile} = require("fs/promises");
const assert = require("assert");
const data = require("./data.json");
const {findClaimLocation} = require("./claim_loc.js");
const {getPubkey} = require("./jwks.js");
const { MAX_AUD_BYTES, MAX_ISS_BYTES, MAX_NONCE_BYTES, MAX_SUB_BYTES, MAX_EXP_BYTES } = require("./constants.js");


const CIRCOM_BIGINT_N = 121;
const CIRCOM_BIGINT_K = 17;
const MAX_MSG_PADDED_BYTES = 1024;

const toCircomBigIntBytes = (num) => {
  const res = [];
  const bigintNum = typeof num == "bigint" ? num : num.valueOf();
  const msk = (1n << BigInt(CIRCOM_BIGINT_N)) - 1n;

  for (let i = 0; i < CIRCOM_BIGINT_K; ++i) {
    res.push(((bigintNum >> BigInt(i * CIRCOM_BIGINT_N)) & msk).toString());
  }
  
  return res;
}

const mergeUInt8Arrays = (a1, a2) => {
  var mergedArray = new Uint8Array(a1.length + a2.length);
  mergedArray.set(a1);
  mergedArray.set(a2, a1.length);
  
  return mergedArray;
}

const int8toBytes = (num) => {
  const arr = new ArrayBuffer(1);
  const view = new DataView(arr);
  view.setUint8(0, num);

  return new Uint8Array(arr);
}

// const int32toBytes = (num) => {
//   const arr = new ArrayBuffer(4);
//   const view = new DataView(arr);
//   view.setUint32(0, num, false);

//   return new Uint8Array(arr);
// }

// https://github.com/zkemail/zk-email-verify/blob/main/packages/helpers/src/binary-format.ts
// Works only on 32 bit sha text lengths
const int64toBytes = (num) => {
  const arr = new ArrayBuffer(8); // an Int32 takes 4 bytes
  const view = new DataView(arr);
  view.setInt32(4, num, false); // byteOffset = 0; litteEndian = false
  return new Uint8Array(arr);
}

const Uint8ArrayToCharArray = (a) => {
  return Array.from(a).map((x) => x.toString());
}

// Puts an end selector, a bunch of 0s, then the length, then fill the rest with 0s.
const sha256Pad = async (prehash_prepad_m, maxShaBytes) => {
  const length_bits = prehash_prepad_m.length * 8; // bytes to bits
  const length_in_bytes = int64toBytes(length_bits);

  prehash_prepad_m = mergeUInt8Arrays(prehash_prepad_m, int8toBytes(2 ** 7));
  while ((prehash_prepad_m.length * 8 + length_in_bytes.length * 8) % 512 !== 0) {
    prehash_prepad_m = mergeUInt8Arrays(prehash_prepad_m, int8toBytes(0));
  }
  prehash_prepad_m = mergeUInt8Arrays(prehash_prepad_m, length_in_bytes);
  assert(
    (prehash_prepad_m.length * 8) % 512 === 0,
    "Padding did not compconste properly!"
  );

  const messageLen = prehash_prepad_m.length;
  while (prehash_prepad_m.length < maxShaBytes) {
    prehash_prepad_m = mergeUInt8Arrays(prehash_prepad_m, int64toBytes(0));
  }

  console.log(prehash_prepad_m.length, maxShaBytes);
  assert(
    prehash_prepad_m.length === maxShaBytes,
    "Padding to max length did not compconste properly!"
  );

  return [prehash_prepad_m, messageLen];
}

const splitJWT = (jwt) => {
  const result = [];
  let i = 0;

  while (jwt.length) {
    i++;
    const chunk = jwt.splice(0, 16);
    result.push(chunk);
  }

  return result
}


const createInputs = async (msg=data.jwt, sig=data.sig) => {
  const signature = toCircomBigIntBytes(BigInt(`0x${Buffer.from(sig, "base64").toString("hex")}`));
  const [jwtPadded, jwtPaddedLen] = await sha256Pad(new TextEncoder().encode(msg), MAX_MSG_PADDED_BYTES);
  const jwt_padded_bytes = jwtPaddedLen.toString();
  const jwt = await Uint8ArrayToCharArray(jwtPadded); 
  const issClaim = findClaimLocation(data.jwt, data.iss, MAX_ISS_BYTES);
  const subClaim = findClaimLocation(data.jwt, data.sub, MAX_SUB_BYTES);
  const audClaim = findClaimLocation(data.jwt, data.aud, MAX_AUD_BYTES);
  const nonceClaim = findClaimLocation(data.jwt, data.nonce, MAX_NONCE_BYTES);
  const rsaPubkey = toCircomBigIntBytes(await getPubkey(data.jwt));
  const salt = "";
  let pubkey = "";
  let randomness = "";
  let exp = "";


  const inputs = {
    jwt_segments: splitJWT(jwt),
    jwt_padded_bytes,
    iss: issClaim[0],
    iss_loc: issClaim[1],
    sub: subClaim[0],
    sub_loc: subClaim[1],
    aud: audClaim[0],
    aud_loc: audClaim[1],
    nonce: nonceClaim[0],
    nonce_loc: nonceClaim[1],
    exp,
    pubkey: BigInt(pubkey).toString(),
    randomness,
    salt,
    signature,
    modulus: rsaPubkey,
  }
  console.log("issClaim[0]",issClaim[0]);
  console.log("inputs.jwt_segments.length:",inputs.jwt_segments.length);
  console.log("inputs.jwt_padded_bytes:",inputs.jwt_padded_bytes);
  console.log("inputs.iss:",inputs.iss.length);
  console.log("inputs.iss_loc:",inputs.iss_loc);
  console.log("inputs.sub:",inputs.sub.length);
  console.log("inputs.sub_loc:",inputs.sub_loc);
  console.log("inputs.aud:",inputs.aud.length);
  console.log("inputs.aud_loc:",inputs.aud_loc);
  console.log("inputs.nonce:",inputs.nonce.length);
  console.log("inputs.nonce_loc:",inputs.nonce_loc);
  // console.log("inputs.exp:",inputs.exp.length);
  // console.log("inputs.exp_loc:",inputs.exp_loc);
  console.log("inputs.salt:",inputs.salt.length);
  console.log("inputs.signature:",inputs.signature.length);
  console.log("inputs.modulus:",inputs.modulus.length);


  await writeFile(
    `${__dirname}/../inputs/ZKLogin.json`,
    JSON.stringify(inputs, null, 2),
  )
}

createInputs()
.then(() => {})
