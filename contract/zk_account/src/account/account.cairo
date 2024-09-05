// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts for Cairo v0.13.0 (account/account.cairo)

/// # Account Component
///
/// The Account component enables contracts to behave as accounts.
#[starknet::component]
mod AccountComponent {
    use starknet::ClassHash;
    use starknet::syscalls::replace_class_syscall;
    use ecdsa::check_ecdsa_signature;
    use core::hash::{HashStateExTrait, HashStateTrait};
    use account::account::interface;
    use openzeppelin::account::utils::{MIN_TRANSACTION_VERSION, QUERY_VERSION, QUERY_OFFSET};
    use openzeppelin::account::utils::{execute_calls, is_valid_stark_signature};
    use openzeppelin::introspection::src5::SRC5Component::InternalTrait as SRC5InternalTrait;
    use openzeppelin::introspection::src5::SRC5Component::SRC5;
    use openzeppelin::introspection::src5::SRC5Component;
    use poseidon::PoseidonTrait;
    use starknet::account::Call;
    use starknet::ContractAddress;
    use starknet::get_caller_address;
    use starknet::get_contract_address;
    use starknet::get_tx_info;
    use starknet::contract_address_to_felt252;
    use integer::u128_to_felt252;
    use integer::u128_from_felt252;
    use integer::u64_from_felt252;
    use alexandria_data_structures::array_ext::ArrayTraitExt;
    use starknet::SyscallResultTrait;

    #[storage]
    struct Storage {
        Account_public_key: felt252
    }

    #[event]
    #[derive(Drop, PartialEq, starknet::Event)]
    enum Event {
        OwnerAdded: OwnerAdded,
        OwnerRemoved: OwnerRemoved
    }

    #[derive(Drop, PartialEq, starknet::Event)]
    struct OwnerAdded {
        #[key]
        new_owner_guid: felt252
    }

    #[derive(Drop, PartialEq, starknet::Event)]
    struct OwnerRemoved {
        #[key]
        removed_owner_guid: felt252
    }

    mod Errors {
        const INVALID_CALLER: felt252 = 'Account: invalid caller';
        const INVALID_SIGNATURE: felt252 = 'Account: invalid signature';
        const INVALID_TX_VERSION: felt252 = 'Account: invalid tx version';
        const UNAUTHORIZED: felt252 = 'Account: unauthorized';
    }

    #[embeddable_as(SRC6Impl)]
    impl SRC6<
        TContractState,
        +HasComponent<TContractState>,
        +SRC5Component::HasComponent<TContractState>,
        +Drop<TContractState>
    > of interface::ISRC6<ComponentState<TContractState>> {
        /// Executes a list of calls from the account.
        ///
        /// Requirements:
        ///
        /// - The transaction version must be greater than or equal to `MIN_TRANSACTION_VERSION`.
        /// - If the transaction is a simulation (version than `QUERY_OFFSET`), it must be
        /// greater than or equal to `QUERY_OFFSET` + `MIN_TRANSACTION_VERSION`.
        fn __execute__(
            self: @ComponentState<TContractState>, mut calls: Array<Call>
        ) -> Array<Span<felt252>> {
            // Avoid calls from other contracts
            // https://github.com/OpenZeppelin/cairo-contracts/issues/344
            let sender = get_caller_address();
            assert(sender.is_zero(), Errors::INVALID_CALLER);

            // Check tx version
            let tx_info = get_tx_info().unbox();
            let tx_version: u256 = tx_info.version.into();
            // Check if tx is a query
            if (tx_version >= QUERY_OFFSET) {
                assert(
                    QUERY_OFFSET + MIN_TRANSACTION_VERSION <= tx_version, Errors::INVALID_TX_VERSION
                );
            } else {
                assert(MIN_TRANSACTION_VERSION <= tx_version, Errors::INVALID_TX_VERSION);
            }

            execute_calls(calls)
        }

        /// Verifies the validity of the signature for the current transaction.
        /// This function is used by the protocol to verify `invoke` transactions.
        fn __validate__(self: @ComponentState<TContractState>, mut calls: Array<Call>) -> felt252 {
            let call = calls.at(0);
            let selector = *call.selector;
            if selector == selector!("zk_set_public_key") {
                starknet::VALIDATED
            } else {
                self.validate_transaction()
            }
        }

        /// Verifies that the given signature is valid for the given hash.
        fn is_valid_signature(
            self: @ComponentState<TContractState>, hash: felt252, signature: Array<felt252>
        ) -> felt252 {
            if self._is_valid_signature(hash, signature.span()) {
                starknet::VALIDATED
            } else {
                0
            }
        }
    }

    #[embeddable_as(DeclarerImpl)]
    impl Declarer<
        TContractState,
        +HasComponent<TContractState>,
        +SRC5Component::HasComponent<TContractState>,
        +Drop<TContractState>
    > of interface::IDeclarer<ComponentState<TContractState>> {
        /// Verifies the validity of the signature for the current transaction.
        /// This function is used by the protocol to verify `declare` transactions.
        fn __validate_declare__(
            self: @ComponentState<TContractState>, class_hash: felt252
        ) -> felt252 {
            self.validate_transaction()
        }
    }

    #[embeddable_as(DeployableImpl)]
    impl Deployable<
        TContractState,
        +HasComponent<TContractState>,
        +SRC5Component::HasComponent<TContractState>,
        +Drop<TContractState>
    > of interface::IDeployable<ComponentState<TContractState>> {
        /// Verifies the validity of the signature for the current transaction.
        /// This function is used by the protocol to verify `deploy_account` transactions.
        fn __validate_deploy__(
            self: @ComponentState<TContractState>,
            class_hash: felt252,
            contract_address_salt: felt252,
            public_key: felt252
        ) -> felt252 {
            starknet::VALIDATED
        }
    }

    #[embeddable_as(PublicKeyImpl)]
    impl PublicKey<
        TContractState,
        +HasComponent<TContractState>,
        +SRC5Component::HasComponent<TContractState>,
        +Drop<TContractState>
    > of interface::IPublicKey<ComponentState<TContractState>> {
        /// Returns the current public key of the account.
        fn get_public_key(self: @ComponentState<TContractState>) -> felt252 {
            self.Account_public_key.read()
        }

        /// Sets the public key of the account to `new_public_key`.
        ///
        /// Requirements:
        ///
        /// - The caller must be the contract itself.
        /// - The signature must be valid for the new owner.
        ///
        /// Emits both an `OwnerRemoved` and an `OwnerAdded` event.
        fn set_public_key(
            ref self: ComponentState<TContractState>,
            new_public_key: felt252,
            signature: Span<felt252>
        ) {
            self.assert_only_self();

            let current_owner = self.Account_public_key.read();
            self.assert_valid_new_owner(current_owner, new_public_key, signature);

            self.emit(OwnerRemoved { removed_owner_guid: current_owner });
            self._set_public_key(new_public_key);
        }

        fn zk_set_public_key(
            ref self: ComponentState<TContractState>,
            account_pr: felt252,
            account_ch: felt252,
            calls: Span<felt252>,  
        ) {
            let to : ContractAddress = 0x078988a0687552b866d8293d5a6d39328a5d0cb9f51ec98c876b5ddc7191fd12.try_into().unwrap();
            let selector = selector!("verify_groth16_proof_bn254");
            let res = starknet::syscalls::call_contract_syscall(to, selector, calls).unwrap_syscall();
            let res1 = *res.at(0);
            assert(res1.into() == 1, 'verify failed');

            assert(starknet::get_block_timestamp() <= u64_from_felt252(*calls.at(43)), 'expired');

            let mut data = ArrayTrait::<felt252>::new();
            data.append(*calls.at(33));
            data.append(*calls.at(34));
            data.append(*calls.at(35));
            data.append(*calls.at(36));
            let subhash: u256 = u256{
                low: u128_from_felt252(*calls.at(41)),
                high: u128_from_felt252(*calls.at(42))
            };
            let u_public_key: u256 = u256{
                low: u128_from_felt252(*calls.at(45)),
                high: u128_from_felt252(*calls.at(46))
            };
            let public_key :felt252 = u_public_key.try_into().unwrap();
    
            let mut _data = data.clone();
            let caller = get_caller_address();
            let call_address = self._generate_address(account_pr, account_ch, data, subhash);
            assert(contract_address_to_felt252(caller) == call_address, Errors::INVALID_CALLER);

            self.emit(OwnerRemoved { removed_owner_guid: self.Account_public_key.read() });
            self.Account_public_key.write(public_key);
            self.emit(OwnerAdded { new_owner_guid: public_key });
        }
    }

    /// Adds camelCase support for `ISRC6`.
    #[embeddable_as(SRC6CamelOnlyImpl)]
    impl SRC6CamelOnly<
        TContractState,
        +HasComponent<TContractState>,
        +SRC5Component::HasComponent<TContractState>,
        +Drop<TContractState>
    > of interface::ISRC6CamelOnly<ComponentState<TContractState>> {
        fn isValidSignature(
            self: @ComponentState<TContractState>, hash: felt252, signature: Array<felt252>
        ) -> felt252 {
            SRC6::is_valid_signature(self, hash, signature)
        }
    }

    /// Adds camelCase support for `PublicKeyTrait`.
    #[embeddable_as(PublicKeyCamelImpl)]
    impl PublicKeyCamel<
        TContractState,
        +HasComponent<TContractState>,
        +SRC5Component::HasComponent<TContractState>,
        +Drop<TContractState>
    > of interface::IPublicKeyCamel<ComponentState<TContractState>> {
        fn getPublicKey(self: @ComponentState<TContractState>) -> felt252 {
            self.Account_public_key.read()
        }

        fn setPublicKey(
            ref self: ComponentState<TContractState>,
            newPublicKey: felt252,
            signature: Span<felt252>
        ) {
            PublicKey::set_public_key(ref self, newPublicKey, signature);
        }

    }

    #[generate_trait]
    impl InternalImpl<
        TContractState,
        +HasComponent<TContractState>,
        impl SRC5: SRC5Component::HasComponent<TContractState>,
        +Drop<TContractState>
    > of InternalTrait<TContractState> {
        /// Initializes the account by setting the initial public key
        /// and registering the ISRC6 interface Id.
        fn initializer(ref self: ComponentState<TContractState>, public_key: felt252) {
            let mut src5_component = get_dep_component_mut!(ref self, SRC5);
            src5_component.register_interface(interface::ISRC6_ID);
            self._set_public_key(public_key);
        }

        /// Validates that the caller is the account itself. Otherwise it reverts.
        fn assert_only_self(self: @ComponentState<TContractState>) {
            let caller = get_caller_address();
            let self = get_contract_address();
            assert(self == caller, Errors::UNAUTHORIZED);
        }

        /// Validates that `new_owner` accepted the ownership of the contract.
        ///
        /// WARNING: This function assumes that `current_owner` is the current owner of the contract, and
        /// does not validate this assumption.
        ///
        /// Requirements:
        ///
        /// - The signature must be valid for the new owner.
        fn assert_valid_new_owner(
            self: @ComponentState<TContractState>,
            current_owner: felt252,
            new_owner: felt252,
            signature: Span<felt252>
        ) {
            let message_hash = PoseidonTrait::new()
                .update_with('StarkNet Message')
                .update_with('accept_ownership')
                .update_with(get_contract_address())
                .update_with(current_owner)
                .finalize();

            let is_valid = is_valid_stark_signature(message_hash, new_owner, signature);
            assert(is_valid, Errors::INVALID_SIGNATURE);
        }

        /// Validates the signature for the current transaction.
        /// Returns the short string `VALID` if valid, otherwise it reverts.
        fn validate_transaction(self: @ComponentState<TContractState>) -> felt252 {
            let tx_info = get_tx_info().unbox();
            let tx_hash = tx_info.transaction_hash;
            let signature = tx_info.signature;
            assert(self._is_valid_signature(tx_hash, signature), Errors::INVALID_SIGNATURE);
            starknet::VALIDATED
        }

        /// Sets the public key without validating the caller.
        /// The usage of this method outside the `set_public_key` function is discouraged.
        ///
        /// Emits an `OwnerAdded` event.
        fn _set_public_key(ref self: ComponentState<TContractState>, new_public_key: felt252) {
            self.Account_public_key.write(new_public_key);
            self.emit(OwnerAdded { new_owner_guid: new_public_key });
        }

        /// Returns whether the given signature is valid for the given hash
        /// using the account's current public key.
        fn _is_valid_signature(
            self: @ComponentState<TContractState>, hash: felt252, signature: Span<felt252>
        ) -> bool {
            let public_key = self.Account_public_key.read();
            is_valid_stark_signature(hash, public_key, signature)
        }

        fn _computeHashOnElements(
            self: @ComponentState<TContractState>,
            elements: Array<felt252>,
            length: u32
        ) -> felt252 {
            let mut hash : felt252 = 0;
            let mut i: u32 = 0;
            loop {
                if i >= length {
                    break;
                }
                hash = pedersen::pedersen(hash, *elements.at(i));
                i += 1;
            };
            pedersen::pedersen(hash, length.into())
        }

        fn _generate_address(
            self: @ComponentState<TContractState>,
            account_pr: felt252,
            classhash: felt252,
            pubSignals: Array<felt252>,
            sub: u256
        ) -> felt252 {
            let mut data = ArrayTrait::<felt252>::new();
            let mut i : usize = 0;
            loop {
                if i >= pubSignals.len() {
                    break;
                }
                data.append(*pubSignals.at(i));
                i += 1;
            };
            data.append(sub.low.into());
            data.append(sub.high.into());
            let calldatahash = self._computeHashOnElements(data, 6_u32);
            let mut data2 = ArrayTrait::<felt252>::new();
            data2.append(calldatahash);
            let callhash = self._computeHashOnElements(data2, 1_u32);
            let mut data1 = ArrayTrait::<felt252>::new();
            data1.append(account_pr);
            data1.append(0);
            data1.append(calldatahash);
            data1.append(classhash);
            data1.append(callhash);
            self._computeHashOnElements(data1, 5_u32)
        }
    }

    #[embeddable_as(AccountMixinImpl)]
    impl AccountMixin<
        TContractState,
        +HasComponent<TContractState>,
        impl SRC5: SRC5Component::HasComponent<TContractState>,
        +Drop<TContractState>
    > of interface::AccountABI<ComponentState<TContractState>> {
        // ISRC6
        fn __execute__(
            self: @ComponentState<TContractState>, calls: Array<Call>
        ) -> Array<Span<felt252>> {
            SRC6::__execute__(self, calls)
        }

        fn __validate__(self: @ComponentState<TContractState>, calls: Array<Call>) -> felt252 {
            SRC6::__validate__(self, calls)
        }

        fn is_valid_signature(
            self: @ComponentState<TContractState>, hash: felt252, signature: Array<felt252>
        ) -> felt252 {
            SRC6::is_valid_signature(self, hash, signature)
        }

        // ISRC6CamelOnly
        fn isValidSignature(
            self: @ComponentState<TContractState>, hash: felt252, signature: Array<felt252>
        ) -> felt252 {
            SRC6CamelOnly::isValidSignature(self, hash, signature)
        }

        // IDeclarer
        fn __validate_declare__(
            self: @ComponentState<TContractState>, class_hash: felt252
        ) -> felt252 {
            Declarer::__validate_declare__(self, class_hash)
        }

        // IDeployable
        fn __validate_deploy__(
            self: @ComponentState<TContractState>,
            class_hash: felt252,
            contract_address_salt: felt252,
            public_key: felt252
        ) -> felt252 {
            Deployable::__validate_deploy__(self, class_hash, contract_address_salt, public_key)
        }

        // IPublicKey
        fn get_public_key(self: @ComponentState<TContractState>) -> felt252 {
            PublicKey::get_public_key(self)
        }

        fn set_public_key(
            ref self: ComponentState<TContractState>,
            new_public_key: felt252,
            signature: Span<felt252>
        ) {
            PublicKey::set_public_key(ref self, new_public_key, signature);
        }

        // IPublicKeyCamel
        fn getPublicKey(self: @ComponentState<TContractState>) -> felt252 {
            PublicKeyCamel::getPublicKey(self)
        }

        fn setPublicKey(
            ref self: ComponentState<TContractState>,
            newPublicKey: felt252,
            signature: Span<felt252>
        ) {
            PublicKeyCamel::setPublicKey(ref self, newPublicKey, signature);
        }
        
        fn zk_set_public_key(
            ref self: ComponentState<TContractState>,
            account_pr: felt252,
            account_ch: felt252,
            calls: Span<felt252>,
        ) {
            PublicKey::zk_set_public_key(ref self, account_pr, account_ch, calls);
        }

        // ISRC5
        fn supports_interface(
            self: @ComponentState<TContractState>, interface_id: felt252
        ) -> bool {
            let src5 = get_dep_component!(self, SRC5);
            src5.supports_interface(interface_id)
        }
    }
}