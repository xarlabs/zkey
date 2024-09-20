import React from "react";
import { GoogleLoginButton, useZkState } from "../../src/index"; // 引入组件
const DemoContent = () => {
  const { userInfo } = useZkState();

  return (
    <div className='container'>
      {userInfo ? (
        <div>
          <p>登录成功</p>
          <p>用户名：{userInfo.name}</p>
          <p>
            头像：
            <img src={userInfo.avatar} alt='' />
          </p>
        </div>
      ) : (
        <>
          <div>logIn</div>
          <GoogleLoginButton clientId='972156063720-9c8ds0de2n7av3ke00sv3k4fo0vldf29.apps.googleusercontent.com' />
        </>
      )}
    </div>
  );
};

export default DemoContent;
