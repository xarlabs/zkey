export default {
  abi: [
    {
      type: "impl",
      name: "UpgradeableImpl",
      interface_name: "openzeppelin::upgrades::interface::IUpgradeable",
    },
    {
      type: "interface",
      name: "openzeppelin::upgrades::interface::IUpgradeable",
      items: [
        {
          type: "function",
          name: "upgrade",
          inputs: [
            {
              name: "new_class_hash",
              type: "core::starknet::class_hash::ClassHash",
            },
          ],
          outputs: [],
          state_mutability: "external",
        },
      ],
    },
    {
      type: "impl",
      name: "AccountMixinImpl",
      interface_name: "account::account::interface::AccountABI",
    },
    {
      type: "struct",
      name: "core::array::Span::<core::felt252>",
      members: [
        {
          name: "snapshot",
          type: "@core::array::Array::<core::felt252>",
        },
      ],
    },
    {
      type: "struct",
      name: "core::starknet::account::Call",
      members: [
        {
          name: "to",
          type: "core::starknet::contract_address::ContractAddress",
        },
        {
          name: "selector",
          type: "core::felt252",
        },
        {
          name: "calldata",
          type: "core::array::Span::<core::felt252>",
        },
      ],
    },
    {
      type: "enum",
      name: "core::bool",
      variants: [
        {
          name: "False",
          type: "()",
        },
        {
          name: "True",
          type: "()",
        },
      ],
    },
    {
      type: "struct",
      name: "core::integer::u256",
      members: [
        {
          name: "low",
          type: "core::integer::u128",
        },
        {
          name: "high",
          type: "core::integer::u128",
        },
      ],
    },
    {
      type: "interface",
      name: "account::account::interface::AccountABI",
      items: [
        {
          type: "function",
          name: "__execute__",
          inputs: [
            {
              name: "calls",
              type: "core::array::Array::<core::starknet::account::Call>",
            },
          ],
          outputs: [
            {
              type: "core::array::Array::<core::array::Span::<core::felt252>>",
            },
          ],
          state_mutability: "view",
        },
        {
          type: "function",
          name: "__validate__",
          inputs: [
            {
              name: "calls",
              type: "core::array::Array::<core::starknet::account::Call>",
            },
          ],
          outputs: [
            {
              type: "core::felt252",
            },
          ],
          state_mutability: "view",
        },
        {
          type: "function",
          name: "is_valid_signature",
          inputs: [
            {
              name: "hash",
              type: "core::felt252",
            },
            {
              name: "signature",
              type: "core::array::Array::<core::felt252>",
            },
          ],
          outputs: [
            {
              type: "core::felt252",
            },
          ],
          state_mutability: "view",
        },
        {
          type: "function",
          name: "supports_interface",
          inputs: [
            {
              name: "interface_id",
              type: "core::felt252",
            },
          ],
          outputs: [
            {
              type: "core::bool",
            },
          ],
          state_mutability: "view",
        },
        {
          type: "function",
          name: "__validate_declare__",
          inputs: [
            {
              name: "class_hash",
              type: "core::felt252",
            },
          ],
          outputs: [
            {
              type: "core::felt252",
            },
          ],
          state_mutability: "view",
        },
        {
          type: "function",
          name: "__validate_deploy__",
          inputs: [
            {
              name: "class_hash",
              type: "core::felt252",
            },
            {
              name: "contract_address_salt",
              type: "core::felt252",
            },
            {
              name: "public_key",
              type: "core::felt252",
            },
          ],
          outputs: [
            {
              type: "core::felt252",
            },
          ],
          state_mutability: "view",
        },
        {
          type: "function",
          name: "get_public_key",
          inputs: [],
          outputs: [
            {
              type: "core::felt252",
            },
          ],
          state_mutability: "view",
        },
        {
          type: "function",
          name: "set_public_key",
          inputs: [
            {
              name: "new_public_key",
              type: "core::felt252",
            },
            {
              name: "signature",
              type: "core::array::Span::<core::felt252>",
            },
          ],
          outputs: [],
          state_mutability: "external",
        },
        {
          type: "function",
          name: "zk_set_public_key",
          inputs: [
            {
              name: "account_pr",
              type: "core::felt252",
            },
            {
              name: "account_ch",
              type: "core::felt252",
            },
            {
              name: "issuer_public_key",
              type: "core::felt252",
            },
            {
              name: "issuer",
              type: "core::felt252",
            },
            {
              name: "pubSignals",
              type: "core::array::Array::<core::felt252>",
            },
            {
              name: "subhash",
              type: "core::integer::u256",
            },
            {
              name: "r",
              type: "core::felt252",
            },
            {
              name: "s",
              type: "core::felt252",
            },
          ],
          outputs: [],
          state_mutability: "external",
        },
        {
          type: "function",
          name: "isValidSignature",
          inputs: [
            {
              name: "hash",
              type: "core::felt252",
            },
            {
              name: "signature",
              type: "core::array::Array::<core::felt252>",
            },
          ],
          outputs: [
            {
              type: "core::felt252",
            },
          ],
          state_mutability: "view",
        },
        {
          type: "function",
          name: "getPublicKey",
          inputs: [],
          outputs: [
            {
              type: "core::felt252",
            },
          ],
          state_mutability: "view",
        },
        {
          type: "function",
          name: "setPublicKey",
          inputs: [
            {
              name: "newPublicKey",
              type: "core::felt252",
            },
            {
              name: "signature",
              type: "core::array::Span::<core::felt252>",
            },
          ],
          outputs: [],
          state_mutability: "external",
        },
      ],
    },
    {
      type: "constructor",
      name: "constructor",
      inputs: [
        {
          name: "public_key",
          type: "core::felt252",
        },
      ],
    },
    {
      type: "event",
      name: "account::account::account::AccountComponent::OwnerAdded",
      kind: "struct",
      members: [
        {
          name: "new_owner_guid",
          type: "core::felt252",
          kind: "key",
        },
      ],
    },
    {
      type: "event",
      name: "account::account::account::AccountComponent::OwnerRemoved",
      kind: "struct",
      members: [
        {
          name: "removed_owner_guid",
          type: "core::felt252",
          kind: "key",
        },
      ],
    },
    {
      type: "event",
      name: "account::account::account::AccountComponent::DebugGene",
      kind: "struct",
      members: [
        {
          name: "kk",
          type: "core::felt252",
          kind: "key",
        },
        {
          name: "si_list",
          type: "core::array::Array::<core::felt252>",
          kind: "data",
        },
        {
          name: "si_list1",
          type: "core::array::Array::<core::felt252>",
          kind: "data",
        },
      ],
    },
    {
      type: "event",
      name: "account::account::account::AccountComponent::Event",
      kind: "enum",
      variants: [
        {
          name: "OwnerAdded",
          type: "account::account::account::AccountComponent::OwnerAdded",
          kind: "nested",
        },
        {
          name: "OwnerRemoved",
          type: "account::account::account::AccountComponent::OwnerRemoved",
          kind: "nested",
        },
        {
          name: "DebugGene",
          type: "account::account::account::AccountComponent::DebugGene",
          kind: "nested",
        },
      ],
    },
    {
      type: "event",
      name: "openzeppelin::introspection::src5::SRC5Component::Event",
      kind: "enum",
      variants: [],
    },
    {
      type: "event",
      name: "openzeppelin::upgrades::upgradeable::UpgradeableComponent::Upgraded",
      kind: "struct",
      members: [
        {
          name: "class_hash",
          type: "core::starknet::class_hash::ClassHash",
          kind: "data",
        },
      ],
    },
    {
      type: "event",
      name: "openzeppelin::upgrades::upgradeable::UpgradeableComponent::Event",
      kind: "enum",
      variants: [
        {
          name: "Upgraded",
          type: "openzeppelin::upgrades::upgradeable::UpgradeableComponent::Upgraded",
          kind: "nested",
        },
      ],
    },
    {
      type: "event",
      name: "account::presets::account::AccountUpgradeable::Event",
      kind: "enum",
      variants: [
        {
          name: "AccountEvent",
          type: "account::account::account::AccountComponent::Event",
          kind: "flat",
        },
        {
          name: "SRC5Event",
          type: "openzeppelin::introspection::src5::SRC5Component::Event",
          kind: "flat",
        },
        {
          name: "UpgradeableEvent",
          type: "openzeppelin::upgrades::upgradeable::UpgradeableComponent::Event",
          kind: "flat",
        },
      ],
    },
  ],
};
