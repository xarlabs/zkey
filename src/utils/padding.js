"use strict";
// Copyright (c) RoochNetwork
// SPDX-License-Identifier: Apache-2.0
Object.defineProperty(exports, "__esModule", { value: true });
exports.padString = void 0;
function padString(str, paddedBytesSize) {
    var paddedBytes = Array.from(str, function (c) { return c.charCodeAt(0); });
    paddedBytes.push.apply(paddedBytes, new Array(paddedBytesSize - paddedBytes.length).fill(0));
    return paddedBytes;
}
exports.padString = padString;
