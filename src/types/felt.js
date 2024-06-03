"use strict";
// Copyright (c) RoochNetwork
// SPDX-License-Identifier: Apache-2.0
Object.defineProperty(exports, "__esModule", { value: true });
exports.Felt = void 0;
var utils_1 = require("../utils");
var Felt = /** @class */ (function () {
    function Felt(val) {
        this.validate(val);
        this.value = val;
    }
    Felt.prototype.validate = function (val) {
        if (val < 0 || val >= Felt.PRIME) {
            throw new Error('Felt value out of range');
        }
    };
    Felt.prototype.toBigNumber = function () {
        return this.value;
    };
    Felt.prototype.toHex = function () {
        return this.value.toString(16);
    };
    Felt.prototype.toString = function () {
        return this.value.toString();
    };
    Felt.prototype.toText = function () {
        return (0, utils_1.decodeShortString)('0x' + this.toHex());
    };
    Felt.fromString = function (text) {
        return new Felt(BigInt((0, utils_1.encodeShortString)(text)));
    };
    Felt.PRIME = BigInt('21888242871839275222246405745257275088548364400416034343698204186575808495617');
    Felt.NEGATIVE_ONE = BigInt('21888242871839275222246405745257275088548364400416034343698204186575808495616');
    return Felt;
}());
exports.Felt = Felt;
