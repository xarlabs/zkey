export interface IHttpParams {
  method: "GET" | "POST" | "PUT" | "DELETE";
  url: string;
  params?: any;
  data?: any;
  headers?: any;
  type?: "json" | "urlencoded" | "form";
}

export interface IResOption {
  method: "GET" | "POST" | "PUT" | "DELETE";
  headers: any;
  body?: any;
}

export enum HeaderTypeEnum {
  "json" = "application/json",
  "urlencoded" = "application/x-www-form-urlencoded",
  "form" = "multipart/form-data",
}

export interface IHttpResponse {
  data: any;
  status: number;
}
