"use strict";

function _typeof(o) { "@babel/helpers - typeof"; return _typeof = "function" == typeof Symbol && "symbol" == typeof Symbol.iterator ? function (o) { return typeof o; } : function (o) { return o && "function" == typeof Symbol && o.constructor === Symbol && o !== Symbol.prototype ? "symbol" : typeof o; }, _typeof(o); }
Object.defineProperty(exports, "__esModule", {
  value: true
});
Object.defineProperty(exports, "GoogleLoginButton", {
  enumerable: true,
  get: function get() {
    return _GoogleLogin["default"];
  }
});
Object.defineProperty(exports, "MainnetName", {
  enumerable: true,
  get: function get() {
    return _walletConfig.MainnetName;
  }
});
Object.defineProperty(exports, "SepoliaName", {
  enumerable: true,
  get: function get() {
    return _walletConfig.SepoliaName;
  }
});
Object.defineProperty(exports, "WalletProvider", {
  enumerable: true,
  get: function get() {
    return _WalletProvider["default"];
  }
});
Object.defineProperty(exports, "ZKeyLoginProvider", {
  enumerable: true,
  get: function get() {
    return _ZkLoginProvider["default"];
  }
});
Object.defineProperty(exports, "useWalletDispatcher", {
  enumerable: true,
  get: function get() {
    return _WalletProvider.useWalletDispatcher;
  }
});
Object.defineProperty(exports, "useWalletState", {
  enumerable: true,
  get: function get() {
    return _WalletProvider.useWalletState;
  }
});
Object.defineProperty(exports, "useZkContext", {
  enumerable: true,
  get: function get() {
    return _ZkLoginProvider.useZkContext;
  }
});
Object.defineProperty(exports, "useZkDispatcher", {
  enumerable: true,
  get: function get() {
    return _ZkLoginProvider.useZkDispatcher;
  }
});
Object.defineProperty(exports, "useZkPrivate", {
  enumerable: true,
  get: function get() {
    return _ZkLoginProvider.useZkPrivate;
  }
});
Object.defineProperty(exports, "useZkState", {
  enumerable: true,
  get: function get() {
    return _ZkLoginProvider.useZkState;
  }
});
var _ZkLoginProvider = _interopRequireWildcard(require("./components/ZkLoginProvider"));
var _GoogleLogin = _interopRequireDefault(require("./components/GoogleLogin"));
var _WalletProvider = _interopRequireWildcard(require("./components/WalletProvider"));
var _walletConfig = require("./config/walletConfig");
function _interopRequireDefault(e) { return e && e.__esModule ? e : { "default": e }; }
function _getRequireWildcardCache(e) { if ("function" != typeof WeakMap) return null; var r = new WeakMap(), t = new WeakMap(); return (_getRequireWildcardCache = function _getRequireWildcardCache(e) { return e ? t : r; })(e); }
function _interopRequireWildcard(e, r) { if (!r && e && e.__esModule) return e; if (null === e || "object" != _typeof(e) && "function" != typeof e) return { "default": e }; var t = _getRequireWildcardCache(r); if (t && t.has(e)) return t.get(e); var n = { __proto__: null }, a = Object.defineProperty && Object.getOwnPropertyDescriptor; for (var u in e) if ("default" !== u && {}.hasOwnProperty.call(e, u)) { var i = a ? Object.getOwnPropertyDescriptor(e, u) : null; i && (i.get || i.set) ? Object.defineProperty(n, u, i) : n[u] = e[u]; } return n["default"] = e, t && t.set(e, n), n; }