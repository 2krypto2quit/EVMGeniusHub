//SPDX-Licesnse-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {Raffle} from "../src/Raffle.sol";

contract DeployRaffle is Script {
    function run() external returns (Raffle) {
        // Deploy the Raffle contract
        Raffle raffle = new Raffle(
            1000000000000000000, // 1 ETH
            86400, // 1 day
            0x8103B0A8A00be2DDC778e6e7eaa21791Cd364625, // VRF Coordinator
            0x474e34a077df58807dbe9c96d3c009b23b3c6d0cce433e59bbf5b34f823bc56c, // Gas Lane
            500000, // Callback Gas Limit
            0 // Subscription ID
        );
        return raffle;
    }
}
