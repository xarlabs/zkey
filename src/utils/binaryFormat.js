"use strict";
// Copyright (c) RoochNetwork
// SPDX-License-Identifier: Apache-2.0
Object.defineProperty(exports, "__esModule", { value: true });
exports.toCircomBigIntBytes = exports.bigIntToChunkedBytes = exports.assert = exports.mergeUInt8Arrays = exports.uint8ToBits = exports.bitsToUint8 = exports.int8toBytes = exports.int64toBytes = exports.Uint8ArrayToCharArray = exports.fromHex = exports.toHex = void 0;
var constants_1 = require("../constants");
// https://stackoverflow.com/a/69585881
var HEX_STRINGS = '0123456789abcdef';
var MAP_HEX = {
    0: 0,
    1: 1,
    2: 2,
    3: 3,
    4: 4,
    5: 5,
    6: 6,
    7: 7,
    8: 8,
    9: 9,
    a: 10,
    b: 11,
    c: 12,
    d: 13,
    e: 14,
    f: 15,
    A: 10,
    B: 11,
    C: 12,
    D: 13,
    E: 14,
    F: 15,
};
// Fast Uint8Array to hex
function toHex(bytes) {
    return Array.from(bytes || [])
        .map(function (b) { return HEX_STRINGS[b >> 4] + HEX_STRINGS[b & 15]; })
        .join('');
}
exports.toHex = toHex;
// Mimics Buffer.from(x, 'hex') logic
// Stops on first non-hex string and returns
// https://github.com/nodejs/node/blob/v14.18.1/src/string_bytes.cc#L246-L261
function fromHex(hexString) {
    var hexStringTrimmed = hexString;
    if (hexString[0] === '0' && hexString[1] === 'x') {
        hexStringTrimmed = hexString.slice(2);
    }
    var bytes = new Uint8Array(Math.floor((hexStringTrimmed || '').length / 2));
    var i;
    for (i = 0; i < bytes.length; i++) {
        var a = MAP_HEX[hexStringTrimmed[i * 2]];
        var b = MAP_HEX[hexStringTrimmed[i * 2 + 1]];
        if (a === undefined || b === undefined) {
            break;
        }
        bytes[i] = (a << 4) | b;
    }
    return i === bytes.length ? bytes : bytes.slice(0, i);
}
exports.fromHex = fromHex;
function Uint8ArrayToCharArray(a) {
    return Array.from(a).map(function (x) { return x.toString(); });
}
exports.Uint8ArrayToCharArray = Uint8ArrayToCharArray;
// Works only on 32 bit sha text lengths
function int64toBytes(num) {
    var arr = new ArrayBuffer(8); // an Int32 takes 4 bytes
    var view = new DataView(arr);
    view.setInt32(4, num, false); // byteOffset = 0 litteEndian = false
    return new Uint8Array(arr);
}
exports.int64toBytes = int64toBytes;
// Works only on 32 bit sha text lengths
function int8toBytes(num) {
    var arr = new ArrayBuffer(1); // an Int8 takes 4 bytes
    var view = new DataView(arr);
    view.setUint8(0, num); // byteOffset = 0 litteEndian = false
    return new Uint8Array(arr);
}
exports.int8toBytes = int8toBytes;
function bitsToUint8(bits) {
    var bytes = new Uint8Array(bits.length);
    for (var i = 0; i < bits.length; i += 1) {
        bytes[i] = parseInt(bits[i], 2);
    }
    return bytes;
}
exports.bitsToUint8 = bitsToUint8;
function uint8ToBits(uint8) {
    return uint8.reduce(function (acc, byte) { return acc + byte.toString(2).padStart(8, '0'); }, '');
}
exports.uint8ToBits = uint8ToBits;
function mergeUInt8Arrays(a1, a2) {
    // sum of individual array lengths
    var mergedArray = new Uint8Array(a1.length + a2.length);
    mergedArray.set(a1);
    mergedArray.set(a2, a1.length);
    return mergedArray;
}
exports.mergeUInt8Arrays = mergeUInt8Arrays;
function assert(cond, errorMessage) {
    if (!cond) {
        throw new Error(errorMessage);
    }
}
exports.assert = assert;
function bigIntToChunkedBytes(
// eslint-disable-next-line @typescript-eslint/ban-types
num, bytesPerChunk, numChunks) {
    var res = [];
    var bigintNum = typeof num == 'bigint' ? num : num.valueOf();
    var msk = (1n << BigInt(bytesPerChunk)) - 1n;
    for (var i = 0; i < numChunks; ++i) {
        res.push(((bigintNum >> BigInt(i * bytesPerChunk)) & msk).toString());
    }
    return res;
}
exports.bigIntToChunkedBytes = bigIntToChunkedBytes;
// eslint-disable-next-line @typescript-eslint/ban-types
function toCircomBigIntBytes(num) {
    return bigIntToChunkedBytes(num, constants_1.CIRCOM_BIGINT_N, constants_1.CIRCOM_BIGINT_K);
}
exports.toCircomBigIntBytes = toCircomBigIntBytes;
