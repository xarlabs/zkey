# Overview

The core functionality of zkLogin is to allow users to verify blockchain transactions using their existing credentials from OpenID Connect platforms (such as Google, Apple, and Facebook) through Zero-Knowledge Proofs (ZKP), without revealing sensitive information or relying on additional trusted parties. ZeroBase primarily handles the ZKP Service, while zKey mainly utilizes this service.

## Core Objectives

Simplify the authentication and transaction processes in Web3 applications while protecting users' privacy and security, driving the development of Web3 applications.

## Benefits of zkLogin

### Convenience

No need to back up private keys or seed phrases. No client or plugin is required. Session keys are used to avoid signing each transaction.

### Security

Inherits advanced account security solutions from Google and Apple (2FA) to protect users’ keys from being lost. Zero-Knowledge Proofs can verify users’ unique Web2 identities on the blockchain, ensuring that only the rightful owner can access the wallet.

### Privacy

Zero-Knowledge Proofs verify users' Web2 identities without revealing the content to the public. The unique salt separates users' on-chain addresses from their off-chain identities.

## Components

### OAuth Provider (OP)

Entities that have implemented the OpenID Connect and OAuth 2.0 protocols, including Google, Apple, and Meta. A key feature of these providers is their ability to issue signed JWTs (JSON Web Tokens) containing a set of claims used to authenticate the end user.

### JWT

A signed statement issued by the OP about the user. We use some of the claims parsed from the JWT to derive the zKey address and verify the user’s identity, including sub, which uniquely identifies the user per provider, iss, which identifies the provider, and aud, which identifies the application.

### User

An end user who owns a zKey address and executes transactions using their existing OpenID credentials.

### Frontend

The frontend application that supports zKey is responsible for storing the session private key, guiding the user through the OAuth login flow, and creating and signing zKey transactions. Since there is no need to securely store or export key pairs, there is no need for additional clients or plugins. The frontend can seamlessly integrate into any Dapp, significantly reducing the complexity for users to interact with Dapps.

### Salt service

zKey currently generates a unique salt and stores it securely. We use Google Cloud to back up the salt and may migrate to additional servers in the future.

### ZKP Service (ZeroBase)

Zero-knowledge proofs (zk-SNARKs) are used to verify the validity of the JWT and salt without revealing the content. We are currently using zk-SNARKs because they are more suitable for handling smaller proof sizes.

### Contract

This includes the Wallet Contract and Authentication Contract on Starknet. The Wallet Contract sets up public key recovery by calling the Authentication Contract and executes transactions. The Authentication Contract consists of a set of Cairo files derived from the circuit and deployed on Starknet. This contract verifies the zero-knowledge proofs and authenticates the transactions.

## Workflow

### Login Overview

- During the user's first login, a public-private key pair is generated and cached locally by the frontend, and the login is completed via the zkLogin circuit.

- For subsequent logins, since the public-private key pair is already cached by the frontend, the user can log in directly without needing to go through the zkLogin circuit again.

- If the user logs out, clears the cache, or logs in from a different device, the frontend will no longer have the cached public-private key pair from the previous session. In this case, when the user clicks the login button again, the frontend will cache a new public-private key pair and log in through the zkLogin circuit. Since the new JWT’s `sub`, `iss`, and `aud` fields remain consistent with the previous ones, the corresponding salt can be found on the cloud server using the `sub` field, allowing the original address to be recreated. The login is then completed by replacing the old public key with the new one for the corresponding address.

### Obtaining JWT

The OP (OpenID Provider) acts as the certificate authority, embedding data into the nonce during the OpenID authentication process.

- The frontend generates a session key pair (pri_k, pub_k), a random number `random1`, and an expiration time `exp`, and computes the nonce as `nonce=H(pub_k, random1, exp)`.
- The user goes through the OP's login flow, passing the `nonce`.
Upon successful authentication, the frontend retrieves a JWT from the OP, represented as `jwt`
- The frontend then parses the JWT to extract `sub`, `iss`, and `aud`. The JWT serves as a certificate for `pub_k`, confirming that the owner of `pri_k` is indeed the user identified by the `sub` issued by the OP.
    - `aud` (Audience): A unique identifier assigned by the OAuth provider to the relying party. The `aud` value extracted from the JWT is compared with the expected `aud` value. If they match, verification is successful; if not, the token is rejected.
    - `sub` (Subject): This field typically contains the user's unique ID, which identifies which user or entity the token corresponds to.

### Retrieving Salt and Address

The on-chain address obtained through zkLogin can be generated from any unique and stable identifier provided by the OP, ensuring that each user has a distinct address. However, this method raises privacy concerns: **when a user logs into different applications, the same identifier may be returned, potentially exposing a link between their on-chain address and their Web2 identity**. To mitigate this, a salt is introduced, which decouples the JWT issued by the OP from the user’s on-chain address.

- The frontend generates a salt and stores it in the salt backup service. (This allows the previous salt to be retrieved if the account is lost, enabling the calculation of the previous address.)

- The frontend computes the on-chain address as `zkaddr = H(sub, aud, iss, salt)`. The frontend then calculates the wallet address as `waddr = H(zkaddr)`.

- The specific implementation within the circuit is `sub_salt_hash = H(sub, salt)`. 

### Obtaining ZKP

We can use the salt and JWT to compute a zero-knowledge proof (ZKP) and demonstrate the connection between pub_k and waddr.

- The frontend sends `jwt`, `OP_k` (OP's public key), `salt`, `pub_k`, and `random1` to the ZKP service to generate the proof. The frontend also sends `iss`, `sub`, `aud`, and `nonce`, which can be parsed from the JWT, to help the ZKP service verify all inputs. Additionally, the frontend still needs to pass `jwt_sha256` and `jwt.length` to the ZKP service and verify the integrity of the JWT within the TEE to reduce circuit constraints.

- The ZKP service returns the proof and public signals, including `ascii(iss)`, `ascii(aud)`, `exp`, `sub_salt_hash`, and `pub_k`. Additionally, iss and aud are converted to ascii(iss) and ascii(aud) because this is the only format the circuit can process.

### Circuit Internal Logic

1. Verify the JWT signature using the provided `OP_k` (OP’s public key) with RSA256.

2. Ensure that the encoded fields `iss`, `sub`, `aud` (first 46 characters in plaintext), and `nonce` are included in the JWT.

3. Decode the Base64-encoded `iss`, `sub`, `aud`, and `nonce` fields into ASCII numbers.

4. Check if `nonce === Poseidon([pub_k, random1, exp])`. (Why verify the nonce? Because the frontend cannot be trusted, this prevents the user from tampering with `pub_k`. `random1` prevents brute-force attacks, and `exp` is customized by the zkLogin project team.)

5. Output `iss` (first 32 characters) and `aud` (first 44 characters).

6. Compute and output the hash of the first 21 significant characters of `sub` and `salt` as `sub_salt_hash = Poseidon(sub, salt)`. (Why hash instead of directly outputting `sub`? To avoid exposing the plaintext value of `sub`.)

7. Output the public inputs `pub_k` and `exp`.

### Submitting Transaction

Since zKey is built on Starknet, which natively supports smart contract wallets, `pub_k` can be embedded within the wallet, eliminating the need to verify the ZKP for every transaction.

- `waddr` will first be deployed to create the corresponding wallet contract with a temporary public key and no private key. This step is solely for establishing the wallet on-chain, as proof verification is not supported during the initial wallet deployment.

- After deploying `waddr`, the frontend submits the proof and public witnesses (`iss`, `aud`, `sub_salt_hash`, `pub_k`, `exp`) to the wallet contract. The wallet contract calculates `waddr` based on `sub_salt_hash` and other public witnesses to ensure the proof is sent to the correct wallet contract. Once verified, the contract will invoke the authentication contract to validate the proof and signals.

- Upon successful verification, `pub_k` will be written into the contract, allowing the user to sign future transactions with `pri_k`.

- When the user needs to reset the session key (such as in the event of key loss), the same process applies, and the old `pub_k` will be replaced by the new `pub_k`. As long as the user retains their OP account and salt, they can retrieve the same address and reset their key pair at any time.

## Code Structure

The code is structured into several main sections:

### Main Circuit File

`ZKLogin_no_sha256.circom`: The main ZKLogin circuit, handling the core zero-knowledge login logic.

1. This circuit verifies the JWT signature (RSA256) by given modulus (without sha256).
2. Ensure the encoded `iss`, `sub`, `aud`(the top 46 in plaintext), `nonce` is included in the JWT token.
3. Base64 decode the `iss`, `sub`, `aud`, `nonce` fields into ascii numbers.
4. Check `nonce` == Poseidon([pubkey, randomness, exp]).
5. Output `iss`(top 32 characters), `aud`(top 44 characters)
6. Compute and output the hash of `sub`(top 21 valid characters) and `salt`.
7. Output the public input `pubkey`, `exp`.

#### Inputs

- `jwt_segments`: Pad the JWT and split it into multiple segments to boost efficiency.
- `jwt_sha256`: The sha256 hash binary of the JWT.
- `iss`: Extract the base64 byte array of the `iss` field from the JWT and pad it to `MAX_ISS_BYTES`(48).
- `sub`: Extract the base64 byte array of the `sub` field from the JWT and pad it to `MAX_SUB_BYTES`(36)
- `aud`: Extract the base64 byte array of the `aud` field from the JWT, taking only the first `MAX_SUB_BYTES bytes`(64) in the array
- `nonce`: Extract the base64 byte array of the `nonce` field from the JWT and pad it to `MAX_NONCE_BYTES`(108).
- `exp`: Custom public input as a preimage of the `nonce`.
- `iss_loc`: The position of `iss` in the JWT.
- `sub_loc`: The position of `sub` in the JWT.
- `aud_loc`: The position of `aud` in the JWT.
- `nonce_loc`: The position of `nonce` in the JWT.
- `salt`: A custom salt, required to be a numeric string. Will be hashed with `sub`.
- `modulus`: Extract the JWT `kid` field in the header to apply to the Google API (https://www.googleapis.com/oauth2/v3/certs) for the public key to verify the JWT signature.
- `signature`: Convert the Base64-encoded JWT signature string to a BigInt array that can be processed by the Circom circuit.
- `pubkey`: Custom starknet public key of Bigint type. Will be hashed with `randomness` to verify `nonce`.
- `randomness`: Custom randomness, required to be a numeric string. Will be hashed with `pubkey` to verify `nonce`.

#### Outputs

- `iss_out_ascii`: The ASCII code of the first 32 characters of the `iss` field. Except for the first three digits "200", each three digits represents an ASCII code.
- `aud_out_ascii`: The ASCII code of the first 44 characters of the `aud` field. Except for the first three digits "200", each three digits represents an ASCII code.
- `sub_salt_hash`: The Poseidon hash of the ascii code of the `sub`(top 21 valid characters) and the `salt`. The hash formula is: `sub_salt_hash` = Poseidon([sub_ascii[top 21 valid characters], salt, exp]).
