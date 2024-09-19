import http from "./api";
import { ProveServiceClient } from "@/config/prove_service_grpc_web_pb.js";
import { ProveRequest } from "@/config/prove_service_pb.js";
import { GaragaServiceClient } from "@/config/garage_grpc_web_pb";
import { GaragaRequest } from "@/config/garage_pb";
import { IHttpResponse } from "./api.d";

// 获取salt
export const getSalt = (token: string) =>
  http({
    method: "POST",
    url: "https://testapi.x.ar/dwgo/api/salt/get_salt",
    data: {
      token,
    },
  });

//获取密钥
export const getPubkey = (jwt: string) => {
  const urlencoded = new URLSearchParams();
  urlencoded.append("jwt", jwt);
  return http({
    method: "POST",
    url: "http://api1.x.ar/jsserver/api/proof/getZkPubdata",
    data: urlencoded,
    type: "urlencoded",
  });
};

// 检查是否deploy
export const checkWalletDeploy = (address: string) =>
  http({
    method: "POST",
    url: "/layer_no/check_deploy",
    data: {
      address,
    },
  });

// 获取当前币的价格
export const getWalletPrices = (tokenAddress: string) =>
  http({
    method: "GET",
    // url: "https://api1.x.ar/dwgo/api/api/wallet/getWalletPrices",
    url: `https://starknet.impulse.avnu.fi/v1/tokens/${tokenAddress}/prices/line`,
    params: {
      // tokenAddress,
      resolution: "1H",
    },
  });

export const getProve = (input: any) =>
  new Promise((resolve, reject) => {
    // http://localhost:8080 https://testapi.x.ar/zkcircuit/
    const client = new ProveServiceClient("https://testapi.x.ar/witness/", null, null);
    const request = new ProveRequest();
    request.setProver("circom");
    request.setTemp("zkLogin");
    request.setInput(input);
    request.setIsEncrypted(false);
    request.setToCaicro(true);
    client.prove(request, {}, (err, response) => {
      if (err) {
        console.log("getProve -> Error: " + err.message);
        reject(err);
      } else {
        console.log("getProve -> success: " + response.getResponse());
        resolve(response.getResponse());
      }
    });
  });

export const getGarage = ({ input, proof }) =>
  new Promise((resolve, reject) => {
    const client = new GaragaServiceClient("https://testapi.x.ar/new_zkcircuit/", null, null);
    const request = new GaragaRequest();
    request.setProof(proof);
    request.setInput(input);
    client.generateCalldata(request, {}, (err, response) => {
      if (err) {
        console.log("getGarage -> Error: " + err.message);
        reject(err);
      } else {
        console.log("getGarage -> success: " + response.getCalldata());
        resolve(response.getCalldata());
      }
    });
  });

export const generateNonce = async (publicKey: string, randomness: string, exp: string) => {
  const urlencoded = new URLSearchParams();
  urlencoded.append("publicKey", publicKey);
  urlencoded.append("randomness", randomness);
  urlencoded.append("exp", exp);
  return http({
    method: "POST",
    url: "https://api1.x.ar/jsserver/api/proof/generateNonce",
    data: urlencoded,
    type: "urlencoded",
  });
};

export const getSubHash = async (subascii: string, salt: string) => {
  const urlencoded = new URLSearchParams();
  urlencoded.append("subascii", subascii);
  urlencoded.append("salt", salt);
  return http({
    method: "POST",
    url: "https://api1.x.ar/jsserver/api/proof/sub_hash",
    data: urlencoded,
    type: "urlencoded",
  });
};
