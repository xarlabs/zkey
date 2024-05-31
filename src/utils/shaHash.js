"use strict";
// Copyright (c) RoochNetwork
// SPDX-License-Identifier: Apache-2.0
Object.defineProperty(exports, "__esModule", { value: true });
exports.sha256Pad = exports.shaHash = void 0;
// import { createHash } from "crypto"
var CryptoJS = require("crypto");
var binaryFormat_1 = require("./binaryFormat");
function shaHash(str) {
    return CryptoJS.createHash('sha256').update(str).digest();
}
exports.shaHash = shaHash;
// Puts an end selector, a bunch of 0s, then the length, then fill the rest with 0s.
function sha256Pad(prehash_prepad_m, maxShaBytes) {
    var length_bits = prehash_prepad_m.length * 8; // bytes to bits
    var length_in_bytes = (0, binaryFormat_1.int64toBytes)(length_bits);
    prehash_prepad_m = (0, binaryFormat_1.mergeUInt8Arrays)(prehash_prepad_m, (0, binaryFormat_1.int8toBytes)(Math.pow(2, 7))); // Add the 1 on the end, length 505
    // while ((prehash_prepad_m.length * 8 + length_in_bytes.length * 8) % 512 !== 0) {
    while ((prehash_prepad_m.length * 8 + length_in_bytes.length * 8) % 512 !== 0) {
        prehash_prepad_m = (0, binaryFormat_1.mergeUInt8Arrays)(prehash_prepad_m, (0, binaryFormat_1.int8toBytes)(0));
    }
    prehash_prepad_m = (0, binaryFormat_1.mergeUInt8Arrays)(prehash_prepad_m, length_in_bytes);
    (0, binaryFormat_1.assert)((prehash_prepad_m.length * 8) % 512 === 0, 'Padding did not complete properly!');
    var messageLen = prehash_prepad_m.length;
    while (prehash_prepad_m.length < maxShaBytes) {
        prehash_prepad_m = (0, binaryFormat_1.mergeUInt8Arrays)(prehash_prepad_m, (0, binaryFormat_1.int64toBytes)(0));
    }
    (0, binaryFormat_1.assert)(prehash_prepad_m.length === maxShaBytes, "Padding to max length did not complete properly! Your padded message is ".concat(prehash_prepad_m.length, " long but max is ").concat(maxShaBytes, "!"));
    return [prehash_prepad_m, messageLen];
}
exports.sha256Pad = sha256Pad;
