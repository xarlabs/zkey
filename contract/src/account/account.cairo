// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts for Cairo v0.18.0 (account/account.cairo)

#[starknet::interface]
trait IVerify<TContractState> {
    fn verify_groth16_proof_bn254(
        self: @TContractState, full_proof_with_hints: Span<felt252>,
    ) -> bool;
}

/// # Account Component
///
/// The Account component enables contracts to behave as accounts.
#[starknet::component]
pub mod AccountComponent {
    use core::hash::{HashStateExTrait, HashStateTrait};
    use core::poseidon::PoseidonTrait;
    use zk_account::account::interface;
    use openzeppelin::account::utils::{MIN_TRANSACTION_VERSION, QUERY_OFFSET};
    use openzeppelin::account::utils::{execute_calls, is_valid_stark_signature};
    use openzeppelin_introspection::src5::SRC5Component::InternalTrait as SRC5InternalTrait;
    use openzeppelin_introspection::src5::SRC5Component::SRC5Impl;
    use openzeppelin_introspection::src5::SRC5Component;
    use starknet::account::Call;
    use starknet::{get_caller_address, get_contract_address, SyscallResultTrait, ContractAddress, get_tx_info, contract_address_to_felt252};
    use starknet::storage::{StoragePointerReadAccess, StoragePointerWriteAccess, Map};
    use super::{IVerifyDispatcher, IVerifyDispatcherTrait};
    use integer::{u128_to_felt252, u128_from_felt252, u64_from_felt252};

    #[storage]
    pub struct Storage {
        pub Zk_public_key: Map<felt252, felt252>
    }

    #[event]
    #[derive(Drop, PartialEq, starknet::Event)]
    pub enum Event {
        OwnerAdded: OwnerAdded,
        OwnerRemoved: OwnerRemoved
    }

    #[derive(Drop, PartialEq, starknet::Event)]
    pub struct OwnerAdded {
        #[key]
        pub new_owner_guid: felt252
    }

    #[derive(Drop, PartialEq, starknet::Event)]
    pub struct OwnerRemoved {
        #[key]
        pub removed_owner_guid: felt252
    }

    pub mod Errors {
        pub const INVALID_CALLER: felt252 = 'Account: invalid caller';
        pub const INVALID_SIGNATURE: felt252 = 'Account: invalid signature';
        pub const INVALID_TX_VERSION: felt252 = 'Account: invalid tx version';
        pub const UNAUTHORIZED: felt252 = 'Account: unauthorized';
    }

    //
    // External
    //

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

            let call = calls.at(0);
            let selector = *call.selector;
            let mut new_calls = ArrayTrait::<Call>::new();
            if selector != selector!("zk_set_public_key") {
                let mut calldata = *call.calldata;
                let mut i : u32 = 0;
                loop {
                    if i > 4 {
                        break;
                    };
                    let _ = calldata.pop_front();
                    i += 1;
                };
                let firstcall : Call = Call {
                    to: *call.to,
                    selector: selector,
                    calldata: calldata,
                };
                new_calls.append(firstcall);
                i = 1;
                loop {
                    if i >= calls.len() {
                        break;
                    }
                    let tmp_call: Call = Call {
                        to: *calls.at(i).to,
                        selector: *calls.at(i).selector,
                        calldata: *calls.at(i).calldata,
                    };
                    new_calls.append(tmp_call);
                    i += 1;
                }
            } else {
                new_calls = calls;
            }
            execute_calls(new_calls.span())
        }

        /// Verifies the validity of the signature for the current transaction.
        /// This function is used by the protocol to verify `invoke` transactions.
        fn __validate__(self: @ComponentState<TContractState>, mut calls: Array<Call>) -> felt252 {
            let call = calls.at(0);
            let selector = *call.selector;
            if selector == selector!("zk_set_public_key") && *call.to == get_contract_address() && calls.len() == 1 {
                starknet::VALIDATED
            } else {
                let mut client_key = ArrayTrait::<felt252>::new();
                let mut i: u32 = 0;
                let calldata =  *call.calldata;
                loop {
                    if i > 4 {
                        break;
                    };
                    client_key.append(*calldata.at(i));
                    i += 1;
                };
                
                self.validate_transaction(client_key.span())
            }
        }

        /// Verifies that the given signature is valid for the given hash.
        fn is_valid_signature(
            self: @ComponentState<TContractState>, hash: felt252, signature: Array<felt252>, client_key: Span<felt252>
        ) -> felt252 {
            if self._is_valid_signature(hash, signature.span(), client_key) {
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
            let mut data = ArrayTrait::<felt252>::new();
            self.validate_transaction(data.span())
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
        fn get_public_key(self: @ComponentState<TContractState>, client_key: Span<felt252>) -> felt252 {
            self.Zk_public_key.read(self._get_key_from_client(client_key))
        }

        /// Sets the public key of the account to `new_public_key`.
        ///
        /// Requirements:
        ///
        /// - The caller checks by verify contract
        ///
        /// Emits both an `OwnerRemoved` and an `OwnerAdded` event.
        fn zk_set_public_key(
            ref self: ComponentState<TContractState>,
            account_pr: felt252,
            account_ch: felt252,
            platform: felt252,
            calls: Span<felt252>,
        ) {
            let verifyContract : ContractAddress = 0x06587074696fab7568ed1650c17fdb63805e0e11995a73721fe8fa30b494f189.try_into().unwrap();
            let verify_result = IVerifyDispatcher { contract_address: verifyContract }.verify_groth16_proof_bn254(calls);
            assert(verify_result, 'verify failed');

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
    
            let caller = get_caller_address();
            let call_address = self._generate_address(account_pr, account_ch, data, subhash);
            assert(contract_address_to_felt252(caller) == call_address, Errors::INVALID_CALLER);

            let mut arr = ArrayTrait::<felt252>::new();
            arr.append(*calls.at(37));
            arr.append(*calls.at(38));
            arr.append(*calls.at(39));
            arr.append(*calls.at(40));
            arr.append(platform);
            let p1 = self._get_key_from_client(arr.span());
            self.emit(OwnerRemoved { removed_owner_guid: self.Zk_public_key.read(p1) });
            self.Zk_public_key.write(p1, public_key);
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
            self: @ComponentState<TContractState>, hash: felt252, signature: Array<felt252>, client_key: Span<felt252>
        ) -> felt252 {
            SRC6::is_valid_signature(self, hash, signature, client_key)
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
        fn getPublicKey(self: @ComponentState<TContractState>, client_key: Span<felt252>) -> felt252 {
            self.Zk_public_key.read(self._get_key_from_client(client_key))
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
            self: @ComponentState<TContractState>, hash: felt252, signature: Array<felt252>, client_key: Span<felt252>
        ) -> felt252 {
            SRC6::is_valid_signature(self, hash, signature, client_key)
        }

        // ISRC6CamelOnly
        fn isValidSignature(
            self: @ComponentState<TContractState>, hash: felt252, signature: Array<felt252>, client_key: Span<felt252>
        ) -> felt252 {
            SRC6CamelOnly::isValidSignature(self, hash, signature, client_key)
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
        fn get_public_key(self: @ComponentState<TContractState>, client_key: Span<felt252>) -> felt252 {
            PublicKey::get_public_key(self, client_key)
        }

        // IPublicKeyCamel
        fn getPublicKey(self: @ComponentState<TContractState>, client_key: Span<felt252>) -> felt252 {
            PublicKeyCamel::getPublicKey(self, client_key)
        }
        
        fn zk_set_public_key(
            ref self: ComponentState<TContractState>,
            account_pr: felt252,
            account_ch: felt252,
            platform: felt252,
            calls: Span<felt252>,
        ) {
            PublicKey::zk_set_public_key(ref self, account_pr, account_ch, platform, calls);
        }

        // ISRC5
        fn supports_interface(
            self: @ComponentState<TContractState>, interface_id: felt252
        ) -> bool {
            let src5 = get_dep_component!(self, SRC5);
            src5.supports_interface(interface_id)
        }
    }

    //
    // Internal
    //

    #[generate_trait]
    pub impl InternalImpl<
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
            src5_component.register_interface(zk_account::outside_execution::interface::SRC5_OUTSIDE_EXECUTION_V2_INTERFACE_ID);
        }

        /// Validates that the caller is the account itself. Otherwise it reverts.
        fn assert_only_self(self: @ComponentState<TContractState>) {
            let caller = get_caller_address();
            let self = get_contract_address();
            assert(self == caller, Errors::UNAUTHORIZED);
        }

        /// Validates the signature for the current transaction.
        /// Returns the short string `VALID` if valid, otherwise it reverts.
        fn validate_transaction(self: @ComponentState<TContractState>, client_key: Span<felt252>) -> felt252 {
            let tx_info = get_tx_info().unbox();
            let tx_hash = tx_info.transaction_hash;
            let signature = tx_info.signature;
            assert(self._is_valid_signature(tx_hash, signature, client_key), Errors::INVALID_SIGNATURE);
            starknet::VALIDATED
        }

        /// Returns whether the given signature is valid for the given hash
        /// using the account's current public key.
        fn _is_valid_signature(
            self: @ComponentState<TContractState>, hash: felt252, signature: Span<felt252>, client_key: Span<felt252>
        ) -> bool {
            let public_key = self.Zk_public_key.read(self._get_key_from_client(client_key));
            is_valid_stark_signature(hash, public_key, signature)
        }
        
        /// compute Hash On Elements
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

        /// genenrate address to check proof pub sigal
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

        /// Returns the felt252 key from the span client key.
        fn _get_key_from_client(self: @ComponentState<TContractState>, client_key: Span<felt252>) -> felt252 {
            let mut i: u32 = 1;
            let mut p1 = *client_key.at(0);
            loop {
                if i >= client_key.len() {
                    break;
                }
                p1 = pedersen::pedersen(p1, *client_key.at(i));
                i += 1;
            };
            p1
        }
    }
}