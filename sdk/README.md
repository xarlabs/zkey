# zkey-react

zkey-react
是基于react框架来使用户可以快速的通过第三方账号（如：google，facebook）来创建并登录web3钱包的组件。

## 特性

- 提供完善的web3钱包功能
- 无需web3相关的知识即可轻松使用
- 支持React、Next框架简单易用
- 高扩展性，提供原型实例方便二次开发

## 流程图

<p align="center">
  <img alt="zkey-react" height="64" src="./demo/zKey-react.png">
</p>

## 安装

```bash
yarn install zkey-react
```

Or

```bash
npm install zkey-react
```

## 使用

### 提供全局provider来管理应用的登录态及钱包实例，务必在应用最外层引入

```jsx
import { ZKeyLoginProvider, WalletProvider } from "zkey-react";

export default App({ children }){
  return (
    <ZKeyLoginProvider>
      <WalletProvider>
        {children}
      </WalletProvider>
    </ZKeyLoginProvider>
  )
}
```

### 登录

在您希望的页面引入并传入该应用clientId

```jsx
import { GoogleLoginButton } from "zkey-react"
export default function Login {
  return (
    <div className='container'>
     <GoogleLoginButton clientId='xxx-xxx' />
    </div>
  );
};

```

## API

### ZKeyLoginProvider

| Prop                 |    Type    |        Description |
| :------------------- | :--------: | -----------------: |
| handleLogInCallback  | `function` | 用户登录后回调函数 |
| handleLogOutCallback | `function` | 用户登出后回调函数 |

### useZkState (提供用户信息及钱包实例)

| Prop            | Type                                                                                                                                                       | Description                                                   |
| --------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------- |
| provider        | `RpcProvider`                                                                                                                                              | 钱包rpc实例（用于二次开发及与内部组件交互）                   |
| userInfo        | `email:string; family_name:string; given_name:string;name: string;picture: string;`                                                                        | 用户信息                                                      |
| globalAccount   | `AccountInterface`                                                                                                                                         | 用户钱包实例（用于二次开发及与内部组件交互）                  |
| globalL3Account | `AccountInterface`                                                                                                                                         | 用户钱包实例L3使用STRK结算gas（用于二次开发及与内部组件交互） |
| walletDetail    | `address: string;callData: string[];exp: string;input: any;isDeploy: boolean;privateKey: string;pub_hash: string;publicKey: string;salt: string;sub: any;` | 钱包相关的配置参数 （用于二次开发及与内部组件交互）           |
| loginLoading    | `boolean`                                                                                                                                                  | 登录态                                                        |
| loadingContent  | `string`                                                                                                                                                   | 登录状态提示文案用于提示用户                                  |

### zkDispatcher (提供用户信息及钱包实例)

| Prop               |    Type    |            Description |
| :----------------- | :--------: | ---------------------: |
| handleChangeDeploy | `function` | 用于切换账号deploy状态 |
| handleUserLogOut   | `function` |                   登出 |
