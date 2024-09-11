import React from "react";
import { createRoot } from "react-dom/client";
import { ZKeyLoginProvider, GoogleLoginButton } from "../../src/index"; // 引入组件

import "./index.scss";
// import WidthAutoLabel from "text-width-auto-label";

const App = () => {
  return (
    <ZKeyLoginProvider>
      <div className='container'>
        <div>logIn</div>
        <GoogleLoginButton clientId='972156063720-9c8ds0de2n7av3ke00sv3k4fo0vldf29.apps.googleusercontent.com' />
      </div>
    </ZKeyLoginProvider>
  );
};
const container = document.getElementById("root");
const root = createRoot(container);
root.render(<App />);
