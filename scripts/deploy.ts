import { ethers } from "hardhat";

async function main() {
  
  const tokenFactory = await ethers.deployContract("TokenFactory", [], {
  });

  await tokenFactory.waitForDeployment();

  console.log(
    `deployed to ${tokenFactory.target}`
  );
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
