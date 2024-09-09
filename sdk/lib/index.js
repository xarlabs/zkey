!(function (e, t) {
  if ("object" == typeof exports && "object" == typeof module) module.exports = t(require("react"));
  else if ("function" == typeof define && define.amd) define(["react"], t);
  else {
    var r = "object" == typeof exports ? t(require("react")) : t(e.React);
    for (var o in r) ("object" == typeof exports ? exports : e)[o] = r[o];
  }
})(self, (e) =>
  (() => {
    "use strict";
    var t = {
        442: (t) => {
          t.exports = e;
        },
      },
      r = {};
    function o(e) {
      var n = r[e];
      if (void 0 !== n) return n.exports;
      var a = (r[e] = { exports: {} });
      return t[e](a, a.exports, o), a.exports;
    }
    (o.n = (e) => {
      var t = e && e.__esModule ? () => e.default : () => e;
      return o.d(t, { a: t }), t;
    }),
      (o.d = (e, t) => {
        for (var r in t)
          o.o(t, r) && !o.o(e, r) && Object.defineProperty(e, r, { enumerable: !0, get: t[r] });
      }),
      (o.o = (e, t) => Object.prototype.hasOwnProperty.call(e, t));
    var n = {};
    o.d(n, { default: () => f });
    var a = o(442),
      c = o.n(a);
    const f = function (e) {
      var t = e.children,
        r = void 0 === t ? "" : t,
        o = (0, a.useRef)(null);
      (0, a.useEffect)(
        function () {
          n();
        },
        [r],
      );
      var n = function () {
        var e = o.current;
        if (e) {
          var t = e.parentNode;
          if (t) {
            var n = getComputedStyle(t, null),
              a = n.fontSize,
              c = n.fontStyle,
              f = n.fontWeight,
              i = n.fontFamily,
              u = t.clientWidth,
              l = t.clientHeight;
            (e.width = u), (e.height = l);
            var p = e.getContext("2d");
            (p.font = "".concat(c, " ").concat(f, " ").concat(a, " ").concat(i)),
              (p.textBaseline = "top");
            var d = Math.ceil((l - Number(a.replace("px", ""))) / 2),
              s = 0,
              v = p.measureText(r).width;
            v < u && (s = (u - v) / 2), p.fillText(r, s, d, u);
          }
        }
      };
      return c().createElement("canvas", { ref: o });
    };
    return n.default;
  })(),
);
