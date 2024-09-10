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
export const getPubkey = (jwt: string) =>
  http({
    method: "POST",
    url: "https://localhost:3000/api/google/getPubkey",
    data: {
      jwt,
    },
  });

// 检查是否deploy
export const checkWalletDeploy = (address: string) =>
  http({
    method: "POST",
    url: "/layer_no/check_deploy",
    data: {
      address,
    },
  });
