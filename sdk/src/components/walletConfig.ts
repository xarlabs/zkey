/*
 * @Author: 汪培良 rick_wang@yunquna.com
 * @Date: 2024-09-05 17:50:06
 * @LastEditors: 汪培良 rick_wang@yunquna.com
 * @LastEditTime: 2024-09-06 10:59:47
 * @FilePath: /webpack5-react-master/src/components/walletConfig.ts
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
//  合约地址
export const xarContract = "0x05fd8ac828ada46b7eaeded3be2e63f5d821f3f2c33ca158b210fd7bb517b244";
export const voxelContract = "0x0440452cb86c2654ee1a9ea1eb8966b0420d687f0abfb290f4ac9e3f3adbbbb3";
export const energyContract = "0x06ca563e0dc3df354190cd8db42db3df370353efe2e692f78cd7e80da0fa7a8e";
export const ethContract = "0x049d36570d4e46f48e99674bd3fcc84644ddd6b96f7c741b1562b82f9e004dc7";
export const strkContract = "0x04718f5a0fc34cc1af16a1cdee98ffb20c31f5cd61d6ab07201858f4287c938d";
export const usdtContract = "0x068f5c6a61780768455de69077e07e89787839bf8166decfbf92b645209c0fb8";
export const usdcContract = "0x053c91253bc9682c04929ca02ed00b3e423f6710d2ee7e0d5ebb06f3ecf368a8";

export const sepoliaUsdtContract =
  "0x069d3d2eb34b27a829d0e374ebd7138c4ae8628498acab5fb429fcbc7f364999";
export const sepoliaUsdcContract =
  "0x01bd7237484b074609961b53f7d8978e921127e53a2af358e59b4b80eb29d640";
// 测试环境
export const SEPOLIA_DEF_CONTRACT_ADDRESS = [
  ethContract,
  strkContract,
  sepoliaUsdtContract,
  sepoliaUsdcContract,
];

// 正式环境
export const MAINNET_DEF_CONTRACT_ADDRESS = [ethContract, strkContract, usdtContract, usdcContract];
// 可用支付gas的钱包地址
export const GAS_ADDRESS = [ethContract, strkContract];
// L3 地址
export const WALLET_V3_ADDRESS = [strkContract];

// rpc 地址
export const nodeUrl = "https://free-rpc.nethermind.io/sepolia-juno/v0_7";

// 测试账号
export const testPrivateKey = "0x460ea0c9712b2d3918cff2d967f314974eeb91ebda2f6b65024d66a70e3bf70";
export const testPublicKey = "0x5b4facbd0895128d8480e2b99391bd7fc31e12a13b38f708941a8a9fc8beccc";
export const testAddress = "0x047585f373226434a5f5c0925a4b959cd28cc741d869e212e70938d752d63f9b";

// new account
// export const OZaccountClassHash = "0x015f16375a75b6c48c6decaf81683af6c06866d28ba546c26241a30de057cba9";

export const OZaccountClassHash =
  "0x015f16375a75b6c48c6decaf81683af6c06866d28ba546c26241a30de057cba9";
