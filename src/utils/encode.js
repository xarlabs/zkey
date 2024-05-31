"use strict";
// Copyright (c) RoochNetwork
// SPDX-License-Identifier: Apache-2.0
var __spreadArray = (this && this.__spreadArray) || function (to, from, pack) {
    if (pack || arguments.length === 2) for (var i = 0, l = from.length, ar; i < l; i++) {
        if (ar || !(i in from)) {
            if (!ar) ar = Array.prototype.slice.call(from, 0, i);
            ar[i] = from[i];
        }
    }
    return to.concat(ar || Array.prototype.slice.call(from));
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.pascalToSnake = exports.utf8ToArray = exports.sanitizeHex = exports.sanitizeBytes = exports.calcByteLength = exports.padLeft = exports.addHexPrefix = exports.removeHexPrefix = exports.buf2hex = exports.btoaUniversal = exports.atobUniversal = exports.stringToArrayBuffer = exports.arrayBufferToString = exports.IS_BROWSER = void 0;
/* eslint-disable no-param-reassign */
exports.IS_BROWSER = typeof window !== 'undefined';
var STRING_ZERO = '0';
/**
 * Some functions recreated from https://github.com/pedrouid/enc-utils/blob/master/src/index.ts
 * enc-utils is not a dependency to avoid using `Buffer` which only works in node and not browsers
 */
/**
 * Convert array buffer to string
 *
 * *[internal usage]*
 */
function arrayBufferToString(array) {
    return new Uint8Array(array).reduce(function (data, byte) { return data + String.fromCharCode(byte); }, '');
}
exports.arrayBufferToString = arrayBufferToString;
/**
 * Convert string to array buffer
 *
 * *[internal usage]*
 */
function stringToArrayBuffer(s) {
    return Uint8Array.from(s, function (c) { return c.charCodeAt(0); });
}
exports.stringToArrayBuffer = stringToArrayBuffer;
/**
 * Convert string to array buffer (browser and node compatible)
 */
function atobUniversal(a) {
    return stringToArrayBuffer(atob(a));
}
exports.atobUniversal = atobUniversal;
/**
 * Convert array buffer to string (browser and node compatible)
 */
function btoaUniversal(b) {
    return btoa(arrayBufferToString(b));
}
exports.btoaUniversal = btoaUniversal;
/**
 * Convert array buffer to hex-string
 * @returns format: hex-string
 */
function buf2hex(buffer) {
    return __spreadArray([], buffer, true).map(function (x) { return x.toString(16).padStart(2, '0'); }).join('');
}
exports.buf2hex = buf2hex;
/**
 * Remove hex prefix '0x' from hex-string
 * @param hex hex-string
 * @returns format: base16-string
 */
function removeHexPrefix(hex) {
    return hex.replace(/^0x/i, '');
}
exports.removeHexPrefix = removeHexPrefix;
/**
 * Add hex prefix '0x' to base16-string
 * @param hex base16-string
 * @returns format: hex-string
 */
function addHexPrefix(hex) {
    return "0x".concat(removeHexPrefix(hex));
}
exports.addHexPrefix = addHexPrefix;
/**
 * Prepend or append to string
 *
 * *[internal usage]*
 */
function padString(str, length, left, padding) {
    if (padding === void 0) { padding = STRING_ZERO; }
    var diff = length - str.length;
    var result = str;
    if (diff > 0) {
        var pad = padding.repeat(diff);
        result = left ? pad + str : str + pad;
    }
    return result;
}
/**
 * Prepend string (default with '0')
 */
function padLeft(str, length, padding) {
    if (padding === void 0) { padding = STRING_ZERO; }
    return padString(str, length, true, padding);
}
exports.padLeft = padLeft;
/**
 * Calculate byte length of string
 *
 * *[no internal usage]*
 */
function calcByteLength(str, byteSize) {
    if (byteSize === void 0) { byteSize = 8; }
    var length = str.length;
    var remainder = length % byteSize;
    return remainder ? ((length - remainder) / byteSize) * byteSize + byteSize : length;
}
exports.calcByteLength = calcByteLength;
/**
 * Prepend '0' to string bytes
 *
 * *[no internal usage]*
 */
function sanitizeBytes(str, byteSize, padding) {
    if (byteSize === void 0) { byteSize = 8; }
    if (padding === void 0) { padding = STRING_ZERO; }
    return padLeft(str, calcByteLength(str, byteSize), padding);
}
exports.sanitizeBytes = sanitizeBytes;
/**
 * Prepend '0' to hex-string bytes
 *
 * *[no internal usage]*
 * @param hex hex-string
 * @returns format: hex-string
 */
function sanitizeHex(hex) {
    hex = removeHexPrefix(hex);
    hex = sanitizeBytes(hex, 2);
    if (hex) {
        hex = addHexPrefix(hex);
    }
    return hex;
}
exports.sanitizeHex = sanitizeHex;
/**
 * Convert utf8-string to Uint8Array
 *
 * Implemented using TextEncoder to make it isomorphic
 * @param str utf8-string
 */
function utf8ToArray(str) {
    return new TextEncoder().encode(str);
}
exports.utf8ToArray = utf8ToArray;
/**
 * String transformation util
 *
 * Pascal case to screaming snake case
 */
var pascalToSnake = function (text) {
    return /[a-z]/.test(text)
        ? text
            .split(/(?=[A-Z])/)
            .join('_')
            .toUpperCase()
        : text;
};
exports.pascalToSnake = pascalToSnake;
