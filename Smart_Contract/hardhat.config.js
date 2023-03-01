require("@nomiclabs/hardhat-waffle")
require("@nomiclabs/hardhat-ethers")
require("@nomiclabs/hardhat-etherscan");

require("hardhat-deploy")
require("solidity-coverage")
require("hardhat-gas-reporter")
require("dotenv").config()
require("hardhat-contract-sizer")



module.exports = {
  solidity: "0.8.17",
  defaultNetwork: "hardhat",
  networks:
  {
    mumbai:{ 
      url: process.env.MUMBAI_URL || "",
      accounts: process.env.PRIVATE_KEY !== undefined ? [process.env.PRIVATE_KEY] : [],
      chainID: 80001,

    }

  },


  etherscan:
  { 
    apiKey: process.env.API_KEY
  }





};
