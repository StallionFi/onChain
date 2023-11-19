import { ethers } from "hardhat";
import { load } from 'ts-dotenv';
import { factoryAbi } from "../AbiBasic";
import { Interface, InterfaceAbi } from "ethers";

const env = load({
  INFURA_API_KEY: String,
  INFURA_SECRET_KEY: String,
  WALLET_PRIVATE_KEY: String,
  ETHERSCAN_API_KEY: String
});

const FatcoryContractMainnet = "0xAa087a1e4D2089558EB7d82CE6FF7A9a21f84fFe";
const FatcoryContractTestnet = "0x013c72125902019e769b0Ee51bcBF509d6914704"

async function main() {
   
    //const provider = ethers.getDefaultProvider(`https://rpc.ankr.com/chiliz`);
    const provider = ethers.getDefaultProvider(`https://spicy-rpc.chiliz.com/`);
    const signer = new ethers.Wallet(env.WALLET_PRIVATE_KEY, provider);

    async function getContract(contractAddress: string, abi: Interface | InterfaceAbi){
        return new ethers.Contract(contractAddress, abi, signer);
    }

    const factory = await getContract(FatcoryContractTestnet, factoryAbi);

    const token = await factory.token(0);
    console.log(token)
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});


