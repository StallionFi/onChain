import { ethers } from "hardhat";
import { load } from 'ts-dotenv';
import { factoryAbi } from "../Abi";
import { Interface, InterfaceAbi } from "ethers";

const env = load({
  INFURA_API_KEY: String,
  INFURA_SECRET_KEY: String,
  WALLET_PRIVATE_KEY: String,
  ETHERSCAN_API_KEY: String
});

const FatcoryContract = "0xAa087a1e4D2089558EB7d82CE6FF7A9a21f84fF";

async function main() {
  
   
    const provider = ethers.getDefaultProvider(`https://spicy-rpc.chiliz.com/`);
    const signer = new ethers.Wallet(env.WALLET_PRIVATE_KEY, provider);

    async function getContract(contractAddress: string, abi: Interface | InterfaceAbi){
        return new ethers.Contract(contractAddress, abi, signer);
    }

    const factory = await getContract(FatcoryContract, factoryAbi);

    const token = await factory.createToken("hi", "h", 100);

    console.log(token);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});


