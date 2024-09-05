### Account Contract

It is based on OpenZeppelin version 0.13.0.

#### Dependencies

```
[dependencies]
openzeppelin = { git = "https://github.com/OpenZeppelin/cairo-contracts.git", tag = "v0.13.0" }
alexandria_ascii = { git = "https://github.com/keep-starknet-strange/alexandria.git"}
```

#### Version of the environment

```
scarb --version
scarb 2.6.3 (e6f921dfd 2024-03-13)
cairo: 2.6.3 (https://crates.io/crates/cairo-lang-compiler/2.6.3)
sierra: 1.5.0
# A specific version of Scarb is needed because the older version's code might not compile after Scarb is upgraded.

starkli --version
0.3.4 (9f6ea67)
# It needs to be updated along with Starknet, otherwise errors may occur during declare.
```

#### Contract deployment process

```
# In the root directory of zk_account
# 1 Compile
scarb build
# 2 declare
starkli declare target/dev/account_AccountUpgradeable.contract_class.json --account *account.json --keystore *keystore.json --network sepolia --max-fee "0.04"
#The current contract has already been declared on the Sepolia testnet, with the class address 0x015f16375a75b6c48c6decaf81683af6c06866d28ba546c26241a30de057cba9.

# Deployment is executed on the client side.
```
