// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts for Cairo v0.18.0 (account/interface.cairo)

use starknet::account::Call;

pub const ISRC6_ID: felt252 = 0x2ceccef7f994940b3962a6c67e0ba4fcd37df7d131417c604f91e03caecc1cd;

//
// Account
//

#[starknet::interface]
pub trait ISRC6<TState> {
    fn __execute__(self: @TState, calls: Array<Call>) -> Array<Span<felt252>>;
    fn __validate__(self: @TState, calls: Array<Call>) -> felt252;
    fn is_valid_signature(self: @TState, hash: felt252, signature: Array<felt252>, client_key: Span<felt252>) -> felt252;
}

#[starknet::interface]
pub trait IDeclarer<TState> {
    fn __validate_declare__(self: @TState, class_hash: felt252) -> felt252;
}

#[starknet::interface]
pub trait IDeployable<TState> {
    fn __validate_deploy__(
        self: @TState, class_hash: felt252, contract_address_salt: felt252, public_key: felt252
    ) -> felt252;
}

#[starknet::interface]
pub trait IPublicKey<TState> {
    fn get_public_key(self: @TState, client_key: Span<felt252>) -> felt252;
    fn zk_set_public_key(
        ref self: TState, 
        account_pr: felt252,
        account_ch: felt252,
        platform: felt252,
        calls: Span<felt252>
    );
}

#[starknet::interface]
pub trait ISRC6CamelOnly<TState> {
    fn isValidSignature(self: @TState, hash: felt252, signature: Array<felt252>, client_key: Span<felt252>) -> felt252;
}

#[starknet::interface]
trait IPublicKeyCamel<TState> {
    fn getPublicKey(self: @TState, client_key: Span<felt252>) -> felt252;
}

//
// Account ABI
//

#[starknet::interface]
pub trait AccountABI<TState> {
    // ISRC6
    fn __execute__(self: @TState, calls: Array<Call>) -> Array<Span<felt252>>;
    fn __validate__(self: @TState, calls: Array<Call>) -> felt252;
    fn is_valid_signature(self: @TState, hash: felt252, signature: Array<felt252>, client_key: Span<felt252>) -> felt252;

    // ISRC5
    fn supports_interface(self: @TState, interface_id: felt252) -> bool;

    // IDeclarer
    fn __validate_declare__(self: @TState, class_hash: felt252) -> felt252;

    // IDeployable
    fn __validate_deploy__(
        self: @TState, class_hash: felt252, contract_address_salt: felt252, public_key: felt252
    ) -> felt252;

    // ISRC6CamelOnly
    fn isValidSignature(self: @TState, hash: felt252, signature: Array<felt252>, client_key: Span<felt252>) -> felt252;
    
    // IPublicKey
    fn get_public_key(self: @TState, client_key: Span<felt252>) -> felt252;
    fn zk_set_public_key(
        ref self: TState, 
        account_pr: felt252,
        account_ch: felt252,
        platform: felt252,
        calls: Span<felt252>
    );

    // IPublicKeyCamel
    fn getPublicKey(self: @TState, client_key: Span<felt252>) -> felt252;
}
