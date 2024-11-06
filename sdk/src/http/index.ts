import http from "./api";
// import JwksClient from "jwks-client";
import { createRemoteJWKSet, exportSPKI } from "jose-browser-runtime";
import { buildEddsa, buildPoseidon } from "circomlibjs";
import nodeForge from "node-forge";

//获取密钥
export const getPubkey = async (jwt: string) => {
  const header = JSON.parse(atob(jwt.split(".")[0]));
  const JWKSetObj = await createRemoteJWKSet(new URL("https://www.googleapis.com/oauth2/v3/certs"));
  const cryptoKey = await JWKSetObj(header, jwt);
  console.log("cryptoKey -->", cryptoKey);
  const signingKey = await exportSPKI(cryptoKey);
  console.log("signingKey -->", JSON.stringify(signingKey));
  const pubKeyData = nodeForge.pki.publicKeyFromPem(signingKey);
  console.log("pubKeyData -->", pubKeyData, JSON.stringify(pubKeyData));
  console.log("pubKeyData.n.toString()", pubKeyData.n.toString());
  return BigInt(pubKeyData.n.toString());
};

// 检查是否deploy
export const checkWalletDeploy = (address: string) =>
  http({
    method: "POST",
    url: "/dwgo/api/layer_no/check_deploy",
    data: {
      address,
    },
  });

// 获取当前币的价格
export const getWalletPrices = (tokenAddress: string) =>
  http({
    method: "GET",
    url: `https://starknet.impulse.avnu.fi/v1/tokens/${tokenAddress}/prices/line`,
    params: {
      // tokenAddress,
      resolution: "1H",
    },
  });

export const getGrpcAll = (input: any, jwtLength: number) => {
  const urlencoded = new URLSearchParams();
  urlencoded.append("input_data", input);
  urlencoded.append("jwt_length", jwtLength);
  return http({
    method: "POST",
    url: `/jsserver/api/proof/rpc_proveAndGaraga`,
    data: urlencoded,
    type: "urlencoded",
  });
};

export const generateNonce = async (publicKey: string, randomness: string, exp: string) => {
  let eddsa = await buildEddsa();
  const F = eddsa.babyJub.F;
  let poseidon = await buildPoseidon();
  let p = BigInt(publicKey);

  const nonce = poseidon([p.toString(), randomness, exp]); //这里不加这个[]会报错
  const data = F.toObject(nonce).toString();
  return data;
};

export const getRpcPublicKey = async () => {
  return http({
    method: "POST",
    url: `/jsserver/api/proof/rpc_get_public_key`,
    type: "urlencoded",
  });
};

export const setOutsideDeploy = (pub_hash: string) => {
  const urlencoded = new URLSearchParams();
  urlencoded.append("pub_hash", pub_hash);
  return http({
    method: "POST",
    url: "/jsserver/api/paymaster/outside_deploy",
    type: "urlencoded",
    data: urlencoded,
  });
};

// 重设公私钥
export const getOutsideExecute = (stringified: string) => {
  const urlencoded = new URLSearchParams();
  urlencoded.append("outsideTransaction1", stringified);
  return http({
    method: "POST",
    url: "/jsserver/api/paymaster/outside_execute",
    type: "urlencoded",
    data: urlencoded,
  });
};
