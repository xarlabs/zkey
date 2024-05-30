# Hikari —— zkLogin for Starknet

XAR is partnering with Salus to introduce Hikari —— the zkLogin scheme based on zero-knowledge proof that simplifies the onboarding process with Web2 credentials. Supported by Starknet Foundation, Hikari promises a simple yet secure wallet experience for the Starknet ecosystem, paving the way for mass adoption.

Overcoming Web3 Onboarding Challenges

There are two major challenges to Web3 onboarding:fiat-crypto-exchange and wallet setup. While the former relies on mediation with the traditional financial world, the latter depends purely on the native technology innovation of crypto.

Metamask is still the dominating wallet to this date. It emphasizes self-custody prioritizing security at the expense of user experience. Though speculative gains lure some users, high onboarding barriers deter many who prioritize user-friendly platforms like social media and gaming. The high barrier of entry for blockchain obstructs users who come for the experience, leaving only casinos.

To address this issue, we need to implement a simpler onboarding process. We need something that does not require a learning curve, and that every netizen can easily access. The answer is zkLogin.

zkLogin Bridges Security and Convenience

zkLogin bridges the gap between security and convenience. In essence, it leverages zero-knowledge proof to verify a user’s Web2 credential as the key to the on-chain wallet while keeping it private from others.

Here's a simplified overview of the process:

Users generate a public-private key pair locally and then verify their identity through OpenID Connect-enabled platforms to verify their Web2 identities.

They provide the public key along with the Web2 identity credential to the ZKP service, which operates locally or through a third-party network run in the trusted computing environment, thus keeping information secure. The ZKP service then generates a zero-knowledge proof, which is passed to the on-chain Authentication Contract. The Authentication Contract can verify that the user is indeed the wallet owner without knowing any sensitive information -  public key or Web2 identity.

Upon successful verification, the wallet can be set up or recovered. If a user loses their public-private key, they can log in with their original Web2 credential, reset the key pair, and regain access.

On Starknet, there's a unique advantage: native support for smart contract wallets. This allows for wallet recovery by overwriting the public-private key pair within the wallet, making it convenient for users to restore access while keeping the on-chain address unchanged. zkLogin, which pairs with smart contract wallets, presents an elegant solution.


While compromised emails may lead to asset theft, enabling two-factor authentication mitigates this risk, like what we do with Gmail, Twitter, Discord, etc. Moreover, even the OpenID Providers(e.g., Google, Meta, Microsoft) can not know any relations between users' Web2 identity and their on-chain addresses, so no one could exert censorship on any particular parties.

In summary, zkLogin allows one-click wallet login while keeping on-chain and Web2 identities separate. There will be no need for mnemonic phrases, and the process can be completed in 1 second, costing only 1 cent.

zkLogin and Mass Adoption

Scaling has long been the bottleneck to Web3, yet we have witnessed a recent leap. Thanks to the zero-knowledge roll-up technology and the Dencun Upgrade, the gas fee on Starknet for a transaction has declined to merely 1/10th of a cent - a threshold that enables daily interactions to be cost-agnostic. With the paymaster integration, transaction fees on Starknet can be paid in other tokens like ETH/USDT/USDC in addition to STRK. Now we can achieve cheap, secure, and convenient blockchain networks. Soon, we will witness even greater reductions in costs and improvements in speed.

We're at a point comparable to the early days of the internet, just before mass adoption. Simplified login methods are key to achieving widespread adoption. Introducing Hikari -  the zkLogin scheme as our solution to change the entire landscape. The structure enables users to set up and recover their wallets in one click while inheriting the same security levels from Web2.

A Streamlined Onboarding Experience

Now users only need to log in to existing Web2 platforms to get an on-chain wallet, allowing users to seamlessly transition into the Web3 world through familiar interfaces. For first-time transactions, project teams can subsidize gas fees through smart contracts, enabling users to complete transactions effortlessly and cross the threshold into this new realm. Even if users lose their keys, they can reset them with a single click using their Web2 identity, ensuring the safety of their assets. Throughout this entire process, users' Web2 identities and their on-chain addresses remain 'zero-knowledge' to the outside world—external parties cannot ascertain the connection between users' identities, thereby safeguarding users' privacy.

This approach is ideal for high-frequency, low-value transactions such as social media and gaming. There will be no difference between a Web2 or Web3 application during the onboarding process. With reduced gas fees and the integration of smart contract wallets and zkLogin, the barriers to entry are significantly diminished, paving the way for widespread adoption across various platforms. People will see a kaleidoscope of Dapps with lasting values flourishing rather than casinos in different disguises.

The Teams Behind The Effort: XAR and Salus

XAR is developing a Web3 AR social platform, placing user experience at the forefront. AR technology marks the revolution of media, transforming from 2D photos/videos to enhanced 3D content that people can immerse in.  Originating from the Happy Farm team, we aim to be the next-gen viral social platform, leveraging the new interacting media format and the economic system based on blockchains.

We have been searching for a wallet product that offers an extremely smooth experience and safeguards security. Passkey and zkLogin were both under consideration, but Passkey faced limitations due to current device development, whereas zkLogin emerged as the optimal solution currently available. Benefiting from the upgrade of Starknet after EIP-4844, the significant reduction in gas fees has made on-chain verification feasible. Therefore, XAR is actively pushing forward the development of the zkLogin wallet, benefiting the entire Web3 ecosystem

Our partner, Salus, renowned for their expertise in ZK research and security, pioneers the development of a decentralized and modular ZK proof layer. This groundbreaking innovation not only ensures computational privacy and unmatched speed but also significantly reduces the time and cost associated with proof generation while upholding principles of decentralization..

XAR and Salus are jointly working on Hiraki, the zkLogin scheme for Starknet, backed by Starknet Foundation. Hikari, meaning "light" in Japanese, encapsulates zkLogin's seamless and rapid registration and login experience. It also represents zkLogin's potential to break through the current confines of Web3, ushering in true mass adoption.

This convergence of all factors - simplified logins, smart wallet contracts, and largely reduced gas fees,  not only facilitates frictionless transactions but also democratizes access to blockchain technology, fostering a more inclusive and interconnected ecosystem.

Hikari demonstrates that the endgame of blockchain infrastructure is imminent, and we are on the verge of a new era characterized by explosive value creation.
