"use strict";
// Copyright (c) RoochNetwork
// SPDX-License-Identifier: Apache-2.0
Object.defineProperty(exports, "__esModule", { value: true });
exports.decodeShortString = exports.encodeShortString = exports.splitLongString = exports.isLongText = exports.isShortText = exports.isText = exports.isDecimalString = exports.isShortString = exports.isASCII = void 0;
var constants_1 = require("../constants");
var encode_1 = require("./encode");
var num_1 = require("./num");
/**
 * Test if string contains only ASCII characters (string can be ascii text)
 */
function isASCII(str) {
    // eslint-disable-next-line no-control-regex
    return /^[\x00-\x7F]*$/.test(str);
}
exports.isASCII = isASCII;
/**
 * Test if string is a Cairo short string (string has less or equal 31 characters)
 */
function isShortString(str) {
    return str.length <= constants_1.TEXT_TO_FELT_MAX_LEN;
}
exports.isShortString = isShortString;
/**
 * Test if string contains only numbers (string can be converted to decimal number)
 */
function isDecimalString(str) {
    return /^[0-9]*$/i.test(str);
}
exports.isDecimalString = isDecimalString;
/**
 * Test if value is a free-from string text, and not a hex string or number string
 */
function isText(val) {
    return typeof val === 'string' && !(0, num_1.isHex)(val) && !(0, num_1.isStringWholeNumber)(val);
}
exports.isText = isText;
/**
 * Test if value is short text
 */
var isShortText = function (val) { return isText(val) && isShortString(val); };
exports.isShortText = isShortText;
/**
 * Test if value is long text
 */
var isLongText = function (val) { return isText(val) && !isShortString(val); };
exports.isLongText = isLongText;
/**
 * Split long text into short strings
 */
function splitLongString(longStr) {
    var regex = RegExp("[^]{1,".concat(constants_1.TEXT_TO_FELT_MAX_LEN, "}"), 'g');
    return longStr.match(regex) || [];
}
exports.splitLongString = splitLongString;
/**
 * Convert an ASCII string to a hexadecimal string.
 * @param str short string (ASCII string, 31 characters max)
 * @returns format: hex-string 248 bits max
 * @example
 * ```typescript
 * const myEncodedString: string = encodeShortString("uri/pict/t38.jpg")
 * // return hex string (ex."0x7572692f706963742f7433382e6a7067")
 * ```
 */
function encodeShortString(str) {
    if (!isASCII(str))
        throw new Error("".concat(str, " is not an ASCII string"));
    if (!isShortString(str))
        throw new Error("".concat(str, " is too long"));
    return (0, encode_1.addHexPrefix)(str.replace(/./g, function (char) { return char.charCodeAt(0).toString(16); }));
}
exports.encodeShortString = encodeShortString;
/**
 * Convert a hexadecimal or decimal string to an ASCII string.
 * @param str representing a 248 bit max number (ex. "0x1A4F64EA56" or "236942575435676423")
 * @returns format: short string 31 characters max
 * @example
 * ```typescript
 * const myDecodedString: string = decodeShortString("0x7572692f706963742f7433382e6a7067")
 * // return string (ex."uri/pict/t38.jpg")
 * ```
 */
function decodeShortString(str) {
    if (!isASCII(str))
        throw new Error("".concat(str, " is not an ASCII string"));
    if ((0, num_1.isHex)(str)) {
        return (0, encode_1.removeHexPrefix)(str).replace(/.{2}/g, function (hex) { return String.fromCharCode(parseInt(hex, 16)); });
    }
    if (isDecimalString(str)) {
        return decodeShortString('0X'.concat(BigInt(str).toString(16)));
    }
    throw new Error("".concat(str, " is not Hex or decimal"));
}
exports.decodeShortString = decodeShortString;
