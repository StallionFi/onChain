## This repo contains smartcontracts, deployment and API scripts for RealRace project 

Contracts include:
- ERC20Upgradable token implementation 
- ERC1167(clone) proxy contract to deploy multiple tokens  

Basic version deploed to chiliz testnet and mainnet
- testnet(verified): https://spicy-explorer.chiliz.com/address/0xd980F00c079839ee7Fc82833bb17eEEe7B28E333/contracts#address-tabs
- mainnet chiliz: https://scan.chiliz.com/address/0xAa087a1e4D2089558EB7d82CE6FF7A9a21f84fFe

Updated version utilizing Chainlink functions to put real world data (horse racing results) onchain to alter token price
- Sepolia testnet (verified): https://sepolia.etherscan.io/address/0xb90DaF2f79a86b2Bc7649B3c41684A2128cEfA2D#code

All the main horse data is also stored on Ipfs using nft.storage library

Deployed using hardhat

Try running some of the following tasks to play around with the project 

```shell
npx hardhat help
npx hardhat run scripts/deploy.ts
npx hardhat compile
```
