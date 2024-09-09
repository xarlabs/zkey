import http from "./api";
export const getSalt = (token: string) =>
  http({
    method: "POST",
    url: "https://testapi.x.ar/dwgo/api/salt/get_salt",
    data: {
      token,
    },
  });
