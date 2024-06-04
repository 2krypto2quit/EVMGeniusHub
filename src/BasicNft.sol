//SPDX-License Identifier: MIT

pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";


// contract represents a collection of NFTs (Non-Fungible Tokens)
// which can be referenced by their unique IDs
contract BasicNft is ERC721 {

    error BasicNtfTokenUriNotFound();

    mapping(uint256 tokenId => string tokenUri) private s_tokenIdToUri;
    uint256 private s_tokenCounter;
                 //Base class constructor - Similar to super() in other languages   
    constructor() ERC721("Dogie", "DOG") {
        s_tokenCounter = 0;  
    }

        function mintNft(string memory tokenUri) public {  
            
            s_tokenIdToUri[s_tokenCounter] = tokenUri; 
            _safeMint(msg.sender, s_tokenCounter);
            s_tokenCounter++;       
        }  

        function tokenURI(uint256 tokenId) public view override returns (string memory){
            if(ownerOf(tokenId) == address(0)){
                revert BasicNtfTokenUriNotFound();
            }
            return s_tokenIdToUri[tokenId];

        }

        function getTokenCounter() public view returns (uint256) {
            return s_tokenCounter;
        }
      
    }

