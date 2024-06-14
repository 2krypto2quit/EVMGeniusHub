// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import { Script, console } from "forge-std/Script.sol";
import { HelperConfig } from "./HelperConfig.s.sol";
import { DecentralizedStableCoin } from "../src/DecentralizedStableCoin.sol";
import { DSCEngine } from "../src/DSCEngine.sol";

contract DeployDSC is Script {
    address[] public tokenAddresses;
    address[] public priceFeedAddresses;
    //DecentralizedStableCoin dsc;
    DSCEngine dscEngine;

    function run() external returns (DecentralizedStableCoin, DSCEngine, HelperConfig) {

        DecentralizedStableCoin dsc = new DecentralizedStableCoin();
        HelperConfig helperConfig = new HelperConfig(); // This comes with our mocks!

        (
            address wethUsdPriceFeed, 
            address wbtcUsdPriceFeed, 
            address weth, 
            address wbtc, 
            uint256 deployerKey
            ) = helperConfig.activeNetworkConfig();

        tokenAddresses = [weth, wbtc];
        priceFeedAddresses = [wethUsdPriceFeed, wbtcUsdPriceFeed];

        vm.startBroadcast(deployerKey);       
        dscEngine = new DSCEngine(tokenAddresses, priceFeedAddresses, address(dsc));
        console.log("DSCEngine address: %s", address(dscEngine));
        address currentOwner = dsc.owner();
       console.log("Current owner of DSC contract: %s", currentOwner);         
        //require(currentOwner == address(this), "Deploy script is not the owner of the DSC contract");
        vm.stopBroadcast();

      dsc.transferOwnership(address(dscEngine));

        return (dsc, dscEngine, helperConfig);
    }
}