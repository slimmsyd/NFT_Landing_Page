
const {ethers, run, network} = require("hardhat");

async function main() {

  const nftContract=  await ethers.getContractFactory("PixelNFT");
  const deployContract= await nftContract.deploy();

  await deployContract.deployed();

  console.log(`Contract was Deployed at ${deployContract.address}`)

  //wait a couple blocks 
  await deployContract.deployTransaction.wait(6);
  await verify(deployContract.address, [])
  const maxTokenIds = await deployContract.getMaxTokenIDS()

  console.log(`This is the max tokenIDS ${maxTokenIds}`)

  async function verify(contractAddress, args)
  { 
    console.log("This is verifying......");
    try{ 
      await run("verify:verify" , { 
        address: contractAddress,
        constructorArguments: args,
    })
    }catch(e)
    {
      if(e.message.toLowerCase().includes("Already Verified")) { 
        console.log("Already verified!")
      }else { 
        console.log(e)
      }
    }


  }



}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
