// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts for Cairo v0.18.0 (presets/account.cairo)

/// # Account Preset
///
/// OpenZeppelin's upgradeable account which can change its public key and declare, deploy, or call
/// contracts.
#[starknet::contract(account)]
pub mod AccountUpgradeable {
    use zk_account::account::AccountComponent;
    use openzeppelin_introspection::src5::SRC5Component;
    use openzeppelin_upgrades::UpgradeableComponent;
    use openzeppelin_upgrades::interface::IUpgradeable;
    use starknet::ClassHash;
    use zk_account::outside_execution::outside_execution::OutsideExecComponent;

    component!(path: AccountComponent, storage: account, event: AccountEvent);
    component!(path: SRC5Component, storage: src5, event: SRC5Event);
    component!(path: UpgradeableComponent, storage: upgradeable, event: UpgradeableEvent);
    // Outside Execution
    component!(path: OutsideExecComponent, storage: outside_exec, event: OutsideExecEvt);

    // Account Mixin
    #[abi(embed_v0)]
    pub(crate) impl AccountMixinImpl =
        AccountComponent::AccountMixinImpl<ContractState>;
    impl AccountInternalImpl = AccountComponent::InternalImpl<ContractState>;

    // Upgradeable
    impl UpgradeableInternalImpl = UpgradeableComponent::InternalImpl<ContractState>;

    #[abi(embed_v0)]
    impl OutsideExecImpl = OutsideExecComponent::OutsideExecImpl<ContractState>;
    
    #[storage]
    pub struct Storage {
        #[substorage(v0)]
        pub account: AccountComponent::Storage,
        #[substorage(v0)]
        pub src5: SRC5Component::Storage,
        #[substorage(v0)]
        pub upgradeable: UpgradeableComponent::Storage,
        #[substorage(v0)]
        outside_exec: OutsideExecComponent::Storage
    }

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        #[flat]
        AccountEvent: AccountComponent::Event,
        #[flat]
        SRC5Event: SRC5Component::Event,
        #[flat]
        UpgradeableEvent: UpgradeableComponent::Event,
        #[flat]
        OutsideExecEvt: OutsideExecComponent::Event
    }

    #[constructor]
    pub fn constructor(ref self: ContractState, public_key: felt252) {
        self.account.initializer(public_key);
    }

    #[abi(embed_v0)]
    impl UpgradeableImpl of IUpgradeable<ContractState> {
        fn upgrade(ref self: ContractState, new_class_hash: ClassHash) {
            self.account.assert_only_self();
            self.upgradeable.upgrade(new_class_hash);
        }
    }
}