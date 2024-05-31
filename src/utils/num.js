"use strict";
// Copyright (c) RoochNetwork
// SPDX-License-Identifier: Apache-2.0
Object.defineProperty(exports, "__esModule", { value: true });
exports.isStringWholeNumber = exports.isHex = void 0;
/**
 * Test if string is hex-string
 * @param hex hex-string
 */
function isHex(hex) {
    return /^0x[0-9a-f]*$/i.test(hex);
}
exports.isHex = isHex;
/**
 * Test if string is whole number (0,1,2,3...)
 */
var isStringWholeNumber = function (value) { return /^\d+$/.test(value); };
exports.isStringWholeNumber = isStringWholeNumber;
