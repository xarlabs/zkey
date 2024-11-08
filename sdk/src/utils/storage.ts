export enum StorageEnum {
  "USER_INFO" = "USER_INFO",
  "WALLET_DETAIL" = "WALLET_DETAIL",
  "CONTRACT_OPTION" = "CONTRACT_OPTION",
  "WALLET_NETWORK" = "WALLET_NETWORK",
}

export function handleLocalStorage(method: string, key: string, value?: any) {
  switch (method) {
    case "get": {
      const temp = window.localStorage.getItem(key);

      if (temp) {
        return temp;
      } else {
        return false;
      }
    }
    case "set": {
      window.localStorage.setItem(key, value);
      break;
    }
    case "remove": {
      window.localStorage.removeItem(key);
      break;
    }
    default: {
      return false;
    }
  }
}

export function handleSessionStorage(method: string, key: string, value?: any) {
  switch (method) {
    case "get": {
      const temp = window.sessionStorage.getItem(key);

      if (temp) {
        return temp;
      } else {
        return false;
      }
    }
    case "set": {
      window.sessionStorage.setItem(key, value);
      break;
    }
    case "remove": {
      window.sessionStorage.removeItem(key);
      break;
    }
    default: {
      return false;
    }
  }
}
