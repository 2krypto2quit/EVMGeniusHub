//SPDX-LICENSE-IDENTIFIER: MIT

pragma solidity ^0.8.19;
import {Script, console} from "forge-std/Script.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {BasicNft} from "src/BasicNft.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {MoodNft} from "src/MoodNft.sol";

contract MintBasicNft is Script {

   string public constant PUG_URI = "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";
   uint256 deployerKey;

    function run() external {

        address mostRecentlyDeployedBasicNft = DevOpsTools.get_most_recent_deployment(
            "BasicNft", 
            block.chainid
            );

        mintNftOnContract(mostRecentlyDeployedBasicNft);

    }

    function mintNftOnContract(address basicNftContractAddress) public {

        vm.startBroadcast();
        BasicNft(basicNftContractAddress).mintNft(PUG_URI);
        vm.stopBroadcast();
    }
}
 contract MintMoodNft is Script {

    function run() external {

        address mostRecentlyDeployedBasicNft  = DevOpsTools.get_most_recent_deployment(
            "MoodNft", 
            block.chainid
            );

            mintNftOnContract(mostRecentlyDeployedBasicNft);
    }

    function mintNftOnContract(address moodNftContractAddress) public {
        vm.startBroadcast();
        MoodNft(moodNftContractAddress).mintNft();
        vm.stopBroadcast();
    }
 }

    contract FlipMoodNft is Script {
        uint256 public constant TokenIdToFlip = 0;

        function run() external{

            address mostRecentlyDeployedBasicNft = DevOpsTools.get_most_recent_deployment(
                "MoodNft",
                block.chainid
            );

            flipMoodNft(mostRecentlyDeployedBasicNft);
        }

        function flipMoodNft(address moodNftContractAddress) public {
            vm.startBroadcast();
            MoodNft(moodNftContractAddress).flipMood(TokenIdToFlip);
            vm.stopBroadcast();
        }
    }
 
