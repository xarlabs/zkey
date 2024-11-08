const webpack = require("webpack");
const path = require("path");

module.exports = {
  resolve: {
    fallback: {
      stream: require.resolve("stream-browserify"),
      buffer: require.resolve("buffer"),
      util: require.resolve("util"),
      assert: require.resolve("assert/"),
    },
    alias: {
      // 定义 import 引用时的别名
      "@": path.resolve(__dirname, "../src"),
      Assets: path.resolve(__dirname, "../assets"),
    },

    // 定义 import 引用时可省略的文件后缀名
    extensions: [".js", ".jsx", ".ts", ".tsx"],
  },
  module: {
    rules: [
      {
        // 编译处理 js 和 jsx 文件
        test: /(\.js(x?)$)|(\.ts(x?))$/,
        use: [
          {
            loader: "babel-loader",
          },
        ],
        exclude: /node_modules/, // 只解析 src 目录下的文件
      },
      {
        test: /\.json$/i,
        type: "json",
      },
    ],
  },
  plugins: [
    new webpack.ProvidePlugin({
      process: "process/browser",
      Buffer: ["buffer", "Buffer"],
    }),
  ],
};
