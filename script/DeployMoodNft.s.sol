//SPDX-License Identifier: MIT

pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {Base64} from  "@openzeppelin/contracts/utils/Base64.sol";
import {MoodNft} from "src/MoodNft.sol";

contract DeployMoodNft is Script {

    uint256 public DEFAULT_ANVIL_PRIVATE_KEY = 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80;
    uint256 public deployerKey;
    
    function run() external returns (MoodNft) {

    deployerKey = DEFAULT_ANVIL_PRIVATE_KEY;   

    string memory sadSvg = vm.readFile("./images/sad.svg");
    string memory happySvg = vm.readFile("./images/happy.svg");

    vm.startBroadcast(deployerKey);
    MoodNft moodNft = new MoodNft(svgToImageURI(sadSvg), svgToImageURI(happySvg));
    vm.stopBroadcast();
    return moodNft;
    }

    function svgToImageURI(string memory svg) public view  returns (string memory) {
        
        string memory baseURI = "data:image/svg+xml;base64,";
        string memory svgBase64Encoded = Base64.encode(
            bytes(string(abi.encodePacked(svg)))
            );

   
        return string(abi.encodePacked(baseURI, svgBase64Encoded));

    }

}
