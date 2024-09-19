import React from "react";
import { Layout } from "antd";
import { createRoot } from "react-dom/client";
import DemoContent from "./content";
import { ZKeyLoginProvider, WalletProvider } from "../../src/index"; // 引入组件
const { Header, Footer, Sider, Content } = Layout;
import "./index.scss";
// import WidthAutoLabel from "text-width-auto-label";

const App = () => {
  return (
    <ZKeyLoginProvider>
      <WalletProvider>
        <Layout
          style={{
            borderRadius: 8,
            overflow: "hidden",
            minHeight: "100vh",
          }}>
          <Header
            style={{
              textAlign: "center",
              color: "#fff",
              height: 64,
              paddingInline: 48,
              lineHeight: "64px",
              backgroundColor: "#4096ff",
            }}>
            zkey-react demo
          </Header>
          <Content>
            <DemoContent />
          </Content>
          <Footer>Footer</Footer>
        </Layout>
      </WalletProvider>
    </ZKeyLoginProvider>
  );
};
const container = document.getElementById("root");
const root = createRoot(container);
root.render(<App />);
