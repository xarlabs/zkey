import React, { useMemo } from "react";
import { GoogleLoginButton, useWalletState, useWalletDispatcher } from "../../src/index"; // 引入组件
const DemoContent = () => {
  const { currencyList, overallBalance } = useWalletState();

  const currencyNode = useMemo(() => {
    return currencyList.map((item, index) => (
      <div key={item.address}>
        <p>name:{item.walletName}</p>
        <p>balance:{item.balance}</p>
        <p>prices:{item.prices}</p>
        <p>sum:{item.sum}</p>
      </div>
    ));
  }, [currencyList]);

  return (
    <div className='container'>
      <div>logIn</div>
      <GoogleLoginButton clientId='972156063720-9c8ds0de2n7av3ke00sv3k4fo0vldf29.apps.googleusercontent.com' />
      <div>total:{overallBalance}</div>
      {currencyNode}
    </div>
  );
};

export default DemoContent;
