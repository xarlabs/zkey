### Account Contract

It is based on OpenZeppelin version 0.18.0.

#### Dependencies

```
[dependencies]
openzeppelin = { git = "https://github.com/OpenZeppelin/cairo-contracts.git", tag = "v0.18.0" }
```

#### Version of the environment

```
scarb --version
scarb 2.8.4 (e6f921dfd 2024-03-13)
cairo: 2.8.4 (https://crates.io/crates/cairo-lang-compiler/2.6.3)
sierra: 1.6.0
# A specific version of Scarb is needed because the older version's code might not compile after Scarb is upgraded.

starkli --version
0.3.5 (9f6ea67)
# It needs to be updated along with Starknet, otherwise errors may occur during declare.
```

#### Contract deployment process

```
# In the root directory of zk_account
# 1 Compile
scarb build
# 2 declare
starkli declare target/dev/account_AccountUpgradeable.contract_class.json --account *account.json --keystore *keystore.json --network sepolia --max-fee "0.04"
#The current contract has already been declared on the Sepolia testnet, with the class address 0x061b78d128f46c178c1d3cdaddc28a903191247750ce7c76507841faf9f21bcb.

# Deployment is executed on the client side.
```
