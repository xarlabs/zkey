import React from "react";
import { createRoot } from "react-dom/client";
import DemoContent from "./content";
import { ZKeyLoginProvider, WalletProvider } from "../../src/index"; // 引入组件

import "./index.scss";
// import WidthAutoLabel from "text-width-auto-label";

const App = () => {
  return (
    <ZKeyLoginProvider>
      <WalletProvider>
        <DemoContent />
      </WalletProvider>
    </ZKeyLoginProvider>
  );
};
const container = document.getElementById("root");
const root = createRoot(container);
root.render(<App />);
