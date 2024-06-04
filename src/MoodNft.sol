//SPDX-License Identifier: MIT

pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";


contract MoodNft is ERC721, Ownable {

    error Erc721Metadata_Uri_Queryfor_NonExistent_Token();
    error MoodNft_CantFlipMoodIfNotOwner();

    enum NFTState {
        SAD,
        HAPPY           
    }

    uint256 private s_tokenCounter;
    string private s_sadSvgUri;
    string private s_happySvgUri;

    mapping(uint256 => NFTState) private s_tokenIdToState;

    event CreatedNFT(uint256 indexed tokenId);

    constructor (string memory sadSvgUri, string memory happySvgUri) ERC721("Mood NFT", "MN") Ownable(msg.sender){
        s_tokenCounter = 0;
        s_sadSvgUri = sadSvgUri;
        s_happySvgUri = happySvgUri;       
    }

    function mintNft() public {  
        uint256 tokenCounter = s_tokenCounter;
        _safeMint(msg.sender, tokenCounter);
        s_tokenCounter++;   

        emit CreatedNFT(tokenCounter);    
    }

    function flipMood(uint256 tokenId) public {
        // if(getApproved(tokenId) != msg.sender && ownerOf(tokenId) != msg.sender) {
        //     revert MoodNft_CantFlipMoodIfNotOwner();
        // }

        if(s_tokenIdToState[tokenId] == NFTState.SAD){
            s_tokenIdToState[tokenId] = NFTState.HAPPY;
        } else {
            s_tokenIdToState[tokenId] = NFTState.SAD;
        }
    }

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory){

        if(ownerOf(tokenId) == address(0)){
            revert Erc721Metadata_Uri_Queryfor_NonExistent_Token();
        }

        string memory imageUri = s_happySvgUri;

        if(s_tokenIdToState[tokenId] == NFTState.SAD){
            imageUri = s_sadSvgUri;
        }
            return string (abi.encodePacked(
                _baseURI(),
                Base64.encode(
                    bytes(
                        abi.encodePacked(
                            '{"name": "Mood NFT #', "", '", ',
                            '"description": "An NFT that changes its mood", ',
                            '"image": "', imageUri, '"}'
                        )
                    )
                )
            ));
        }

        function getHappySVG() public view returns (string memory) {
            return s_happySvgUri;
        }

        function getSadSVG() public view returns (string memory) {
            return s_sadSvgUri;
        }

        function getTokenCounter() public view returns (uint256) {
            return s_tokenCounter;
        }
    }


