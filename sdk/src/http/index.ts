import http from "./api";

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
