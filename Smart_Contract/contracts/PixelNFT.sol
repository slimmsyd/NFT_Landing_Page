// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";



error contract_Owner();
contract PixelNFT is ERC1155 { 

    //ID assigned to the contract
    //price of the tokens 
    //owner of the contract
     //counter to keep track of the contract
    //where the NFT is stored baseURI 
    //number of contracts to MINT!

    uint256 public constant pixelNFT = 0;
    uint256 private immutable i_maxTokenIDS = 1000; 
    uint256 private immutable i_price = 0.01 ether; 
    address private immutable i_owner; 

    uint256 public tokenIDS = 0;


    string private baseURI = "ipfs://QmSckkSGrn9JHMvfhMhHF1cZfaM4DGmzmy2zkUSp6Jd91x/metadata.json";


        modifier onlyOwner() { 
        
        if(i_owner != msg.sender)
        { 
            revert contract_Owner();
        }
        _;
    }



receive() external payable{}
fallback() external payable{}


constructor() ERC1155(baseURI)
{
    i_owner = msg.sender ;
}

function mint() public payable
{ 
    //make sure that the caller doesn't have 2 already 
    require(balanceOf(msg.sender, 0) <= 2, "You can't mint no more tokens" );
    //We maxed out on TOkens 
    require(tokenIDS <= i_maxTokenIDS, "There is no more token ids to mint");
    //you have the money,
    require(msg.value >= i_price, "Send more money ya broke boy");

    _mint(msg.sender, 0, 1, "");

    //increment the tokens 
    tokenIDS += 1;

}

//withdraw function 

function withdraw() onlyOwner public{ 
    address owner = i_owner ;
    uint256 amount = address(this).balance; 
    (bool sent,) = owner.call{value: amount}("");
    require(sent, "Failed to send ether");



}


//get msg.sender token bal 

function getSenderTokenBal( address _sender) public view returns(uint256)
{ 
    return balanceOf(_sender, 0);
}


//get max tokends 

function getMaxTokenIDS() public pure returns(uint256)
{
     return i_maxTokenIDS;
}

//get the balance of this contract 


function getBalanceOfContract() onlyOwner public view returns(uint256)
{ 
    return address(this).balance;

}










}