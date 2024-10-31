#[starknet::component]
mod OutsideExecComponent {
    use zk_account::outside_execution::interface::{IOutsideExecution_V2, OutsideExecution};
    use zk_account::outside_execution::hash::calculate_outside_execution_hash;
    use zk_account::account::interface::AccountABI;
    use openzeppelin::account::utils::{execute_calls, is_valid_stark_signature};
    use starknet::{
        ContractAddress, get_contract_address, get_caller_address, get_block_timestamp, get_tx_info
    };
    use starknet::storage::{StoragePointerReadAccess, StoragePointerWriteAccess, Map};
    use starknet::account::Call;

    mod Errors {
        const SELF_CALL: felt252 = 'SELF_CALL';
        const INVALID_CALLER: felt252 = 'INVALID_CALLER';
        const INVALID_TIMESTAMP: felt252 = 'INVALID_TIMESTAMP';
        const INVALID_NONCE: felt252 = 'INVALID_NONCE';
        const INVALID_SIG: felt252 = 'INVALID_SIG';
    }

    #[storage]
    struct Storage {
        outside_nonces: Map<felt252, bool>
    }

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {}

    #[embeddable_as(OutsideExecImpl)]
    impl ExternalImpl<
        TContractState,
        +HasComponent<TContractState>,
        +AccountABI<TContractState>,
        +Drop<TContractState>,
    > of IOutsideExecution_V2<ComponentState<TContractState>> {
        fn execute_from_outside_v2(
            ref self: ComponentState<TContractState>,
            outside_execution: OutsideExecution,
            signature: Array<felt252>
        ) -> Array<Span<felt252>> {
            validate_caller(outside_execution.caller);
            validate_no_self_calls(outside_execution.calls);

            assert(
                self.is_valid_outside_execution_nonce(outside_execution.nonce),
                Errors::INVALID_NONCE
            );

            let tx_hash = calculate_outside_execution_hash(@outside_execution);

            let mut client_key = ArrayTrait::<felt252>::new();  
            let call = outside_execution.calls.at(0);
            let selector = *call.selector;
            let mut new_calls = ArrayTrait::<Call>::new();
            if selector != selector!("zk_set_public_key") {
                let mut calldata = *call.calldata;
                let mut i : u32 = 0;
                loop {
                    if i > 4 {
                        break;
                    };
                    client_key.append(*calldata.at(i));
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
                    if i >= outside_execution.calls.len() {
                        break;
                    }
                    let tmp_call: Call = Call {
                        to: *outside_execution.calls.at(i).to,
                        selector: *outside_execution.calls.at(i).selector,
                        calldata: *outside_execution.calls.at(i).calldata,
                    };
                    new_calls.append(tmp_call);
                    i += 1;
                }
            } else {
                let mut i : u32 = 0;
                loop {
                    if i >= outside_execution.calls.len() {
                        break;
                    }
                    let tmp_call: Call = Call {
                        to: *outside_execution.calls.at(i).to,
                        selector: *outside_execution.calls.at(i).selector,
                        calldata: *outside_execution.calls.at(i).calldata,
                    };
                    new_calls.append(tmp_call);
                    i += 1;
                }
            }
            
            assert(
                self
                    .get_contract()
                    .is_valid_signature(
                        tx_hash, signature, client_key.span()
                    ) == starknet::VALIDATED,
                Errors::INVALID_SIG
            );

            self.outside_nonces.write(outside_execution.nonce, true);

            execute_calls(new_calls.span())
        }

        fn is_valid_outside_execution_nonce(
            self: @ComponentState<TContractState>, nonce: felt252
        ) -> bool {
            !self.outside_nonces.read(nonce)
        }
    }

    fn validate_caller(caller: ContractAddress) {
        if caller.into() != 'ANY_CALLER' {
            assert(get_caller_address() == caller, Errors::INVALID_CALLER);
        }
    }

    fn validate_no_self_calls(mut calls: Span<Call>) {
        let self_address = get_contract_address();
        loop {
            match calls.pop_front() {
                Option::Some(call) => { assert(*call.to != self_address, Errors::SELF_CALL); },
                Option::None(_) => { break; },
            };
        };
    }

    fn validate_timestamp(execute_after: u64, execute_before: u64) -> u64 {
        let timestamp = get_block_timestamp();
        assert(execute_after < timestamp && timestamp < execute_before, Errors::INVALID_TIMESTAMP);
        timestamp
    }
}
