# zKey —— zkLogin for Starknet

zKey is the zkLogin on Starknet, a self-custodial wallet using zero-knowledge proof that allows you to login to Dapps with your familiar social accounts like Google, Apple, and Meta. A new user will be able to be onboarded onto Starknet in just seconds. zKey also integrates with session key and paymaster, offering a blockchain-free experience, aiming to open up a Consumer Web3 era.

Try now: zkey.org

# The Architecture of zKey
<p align="center">
  <img src="~assets/Image/zKey%20Flowchart.jpg" alt="Starknet.unity logo" width="200px"/>
</p >

## Get JWT As The Certificate

In the process of zKey, the OP(OAuth Provider) is utilized as a certificate authority by embedding data into the nonce during the OpenID authentication process.

1. The frontend generates a session key pair `(pri_k, pub_k)`, a randomness `random1`, an expiry time `exp`, and computes the nonce via `nonce=H(pub_k, random1, exp)`.

2. OP login

2.1 User goes through OP’s login flow and passes in the `nonce`. 
2.2 Upon successful authentication, the frontend gets a JWT, denoted as `jwt` , from the OP. The `jwt` serves as a certificate for `pub_k`, confirming that the owner of `pri_k` is indeed the user identified by OP.

## Get Wallet Address

zKey addresses can be generated from any unique and stable identifier provided by the OP to ensure that each user has a distinct address. We currently utilize `sub` as the unique identifier.

3. The frontend parses `jwt` to get `sub`, `iss`,`aud`, and computes the zKey address `waddr = H(sub, aud, iss)` . 

## Get ZKP

Now we can use the JWT to compute a zero-knowledge proof and demonstrate the association between `pub_k` and `waddr` .

We currently utilize a zKey Prover to generate the proof, as the computation might be challenging on users' local devices. This service operates within the TEE, ensuring no sensitive information is leaked. The average generation time is approximately 200 mili seconds.

4. Get proof

4.1 The frontend passes `jwt`, `OP_k`(OP’s public key), `pub_k`, `random1` to the Prover to generate a proof. The frontend also passes `iss`, `sub`, `aud`, `nonce`that can be parsed from `jwt` to help the Prover verify all the inputs.
4.2 The Prover returns a proof and public signals including  `assic(sub)`,`assic(iss)`, `assic(aud)`, `exp`, `pub_k`. Additionally,`sub` ,`iss` and `aud` are converted to`assic(sub)`,  `ascii(iss)` and `ascii(aud)` as it's the only format the circuit can handle.

## Submit Transaction

Since zKey is built on Starknet, which natively supports smart contract wallets, the `pub_k` can be embedded into the wallet, eliminating the need to verify the proof for every transaction. Additionally, the circuit is a Solidity circuit, compatible with other blockchains, and isconverted into a Cairo-verifiable circuit through Garaga.

5.  `waddr` will be deployed initially to create the corresponding Wallet Contract, with a temporary public key and no private key. This step is solely for establishing the wallet on-chain, as the function does not support proof verification during the initial wallet deployment. After the initial deployment of `waddr`, the frontend submits a proof and public signals to the Wallet Contract. The Wallet Contract computes `waddr` from the public signals to ensure the proof is sent to the correct Wallet Contract. 

6. Verify

6.1 Once verified, the Wallet Contract calls the Verifier Contract to validate the proof and public signals. 
6.2 The Verifier returns Yes or No.

7. Upon successful verification, `pub_k` is written into the contract, and the user only needs to sign with `pri_k` for future transactions. When users need to reset the session keys(this occurs in scenarios such as when they lose their keys), the same process applies, and the old `pub_k` will be overwritten with the new `pub_k`. As long as they retain the OP's account they can retrieve the same address and reset their key pair at any time.

# Where zKey Is Positioned
The key advantages of zKey's architecture are its lightweight design, strong compatibility, and seamless integration with Web2 products. zKey, combined with session key and paymaster, will make Consumer Crypto a reality

# Directory Descriptions

- `contract`: Cairo contract.

  - `zk_account`: Account Contract. Please read [readme](https://github.com/xarlabs/zkey/blob/main/contract/zk_account/README.md).
- `circom`: Please read [readme](https://github.com/xarlabs/zkey/blob/main/circom/README.md).
