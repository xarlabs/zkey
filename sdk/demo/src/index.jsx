import React from "react";
import { createRoot } from "react-dom/client";
import WidthAutoLabel from "../../src/index"; // 引入组件
import "./index.scss";
// import WidthAutoLabel from "text-width-auto-label";

const App = () => {
  return (
    <div className='container'>
      <div className='text'>
        <p>示例文本：</p>
        <p>文本宽度自适应标签组件</p>
      </div>
      <div className='normal'>
        <p>宽度100px：</p>
        <p>文本宽度自适应标签组件</p>
      </div>
      <div className='style1'>
        <p>宽度100px：</p>
        <p>
          <WidthAutoLabel>文本宽度自适应标签组件</WidthAutoLabel>
        </p>
      </div>
      <div className='style2'>
        <p>宽度80px：</p>
        <p>
          <WidthAutoLabel>文本宽度自适应标签组件</WidthAutoLabel>
        </p>
      </div>
      <div className='style3'>
        <p>宽度50px：</p>
        <p>
          <WidthAutoLabel>文本宽度自适应标签组件</WidthAutoLabel>
        </p>
      </div>
    </div>
  );
};
const container = document.getElementById("root");
const root = createRoot(container);
root.render(<App />);
