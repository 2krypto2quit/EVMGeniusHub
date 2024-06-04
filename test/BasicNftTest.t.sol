//SPDX-License Identifier: MIT

pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Test, console} from "forge-std/Test.sol";
import {BasicNft} from "src/BasicNft.sol";
import {DeployBasicNft} from "../script/DeployBasicNft.s.sol";
import {StdCheats} from "forge-std/StdCheats.sol";
import {MintBasicNft} from "../script/Interactions.s.sol";

contract BasicNftTest is Test {

   string constant NFT_NAME = "Dogie";
   string constant NFT_SYMBOL = "DOG";
   DeployBasicNft public deployer;
   BasicNft public basicNft;
   address public deployerAddress;    
   string public constant PUG_URI = "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";
   address public constant USER = address(1);

    function setUp() public {

     deployer = new DeployBasicNft();
     basicNft = deployer.run();
    }

    function testInitCorrectly() public {
      assert(keccak256(abi.encodePacked(basicNft.name())) == keccak256(abi.encodePacked(NFT_NAME)));
      assert(keccak256(abi.encodePacked(basicNft.symbol())) == keccak256(abi.encodePacked(NFT_SYMBOL)));
    }
        
      

     function testNameIsCorrect() public view {
        
        string memory expectedName = "Dogie";
        string memory actualName = basicNft.name();

        //string comparison can't be done directly in solidity so we use keccak256
        // strings are converted to bytes before comparison
        // keccak256 returns a hash of the input
        // abi.encodePacked concatenates the two strings
        // keccak256(abi.encodePacked(expectedName)) returns a hash of the expectedName
        // keccak256(abi.encodePacked(actualName)) returns a hash of the actualName
        // if the two hashes are equal, the strings are equal
        // if the two hashes are not equal, the strings are not equal

        assert(keccak256(abi.encodePacked(expectedName)) == keccak256(abi.encodePacked(actualName)));

     }

     function testCanMintAndHaveBalance() public {
        
        vm.prank(USER);
        basicNft.mintNft(PUG_URI);
        assert(basicNft.balanceOf(USER) == 1);    
        
        }

        function testTokenUriIsCorrect() public {
         vm.prank(USER);
         basicNft.mintNft(PUG_URI);
         assert(keccak256(abi.encodePacked(basicNft.tokenURI(0))) == keccak256(abi.encodePacked(PUG_URI)));
        }

        function testMintWithScript() public {
         uint256 startingTokenCount = basicNft.getTokenCounter();
         MintBasicNft mintBasicNft = new MintBasicNft();
         mintBasicNft.mintNftOnContract(address(basicNft));
         assert(basicNft.getTokenCounter() == startingTokenCount + 1);
        }

}

