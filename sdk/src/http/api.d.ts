export interface IHttpParams {
  method: "GET" | "POST" | "PUT" | "DELETE";
  url: string;
  params?: any;
  data?: any;
  headers?: any;
}

export interface IResOption {
  method: "GET" | "POST" | "PUT" | "DELETE";
  headers: any;
  body?: any;
}
