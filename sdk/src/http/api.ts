import { IHttpParams, IResOption } from "./api.d";

const BASE_API_URL = "https://api1.x.ar/dwgo/api";
function http(obj: IHttpParams) {
  let { method, url, params, data, headers = {} } = obj;

  // 处理url 非http url 自动拼接
  if (url.indexOf("http") === -1) {
    url = BASE_API_URL + url;
  }
  // 判断是否有params参数
  // 1、如果有params参数，则把params对象转换成 key=value&key=value的形式，并且拼接到url之后
  // 2、如果没有params参数，则不管
  if (params) {
    // 把对象转换成 key=value&key=value
    let str = new URLSearchParams(params).toString();
    // 拼接到url上
    url += "?" + str;
  }

  let res;

  return new Promise(async (resolve, reject) => {
    try {
      // 判断数据是否为formData类型
      const isFormData = Object.prototype.toString.call(data) === "[object FormData]";
      let reqOption: IResOption = {
        method: method,
        headers: {
          "Content-Type": isFormData ? "application/form-data" : "application/json",
          ...headers,
        },
      };
      if (data) {
        reqOption.body = isFormData ? data : JSON.stringify(data);
      }
      res = await fetch(url, reqOption);
      if (res.status !== 200) {
        reject(res);
      } else {
        resolve(res.json());
      }
    } catch (error) {
      reject(error);
    }
  });
}

export default http;
