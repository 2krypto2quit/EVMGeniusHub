//SPDX-License Identifier: MIT

pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Test} from "forge-std/Test.sol";
import {BasicNft} from "src/BasicNft.sol";
import {DeployBasicNft} from "../script/DeployBasicNft.s.sol";

contract BasicNftTest is Test {

    DeployBasicNft public deployer;
    BasicNft public basicNft;
    address public USER = makeAddr("user");
    string public constant PUG = "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    function setUp() public {

     deployer = new DeployBasicNft();
     basicNft = deployer.run();
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
        basicNft.mintNft(PUG);

        assert(basicNft.balanceOf(USER) == 1);
        assert(keccak256(abi.encodePacked(basicNft.tokenURI(0))) == keccak256(abi.encodePacked(PUG)));
        
        }

}

