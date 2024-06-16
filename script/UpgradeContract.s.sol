// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {ContractA} from "../src/ContractA.sol";
import {ContractB} from "../src/ContractB.sol";
import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";

contract Upgrade is Script {

    function run() external returns (address) {
        address mostRecentlyDeployedProxy = DevOpsTools.get_most_recent_deployment("ERC1967Proxy", block.chainid);
        vm.startBroadcast();
        ContractB newaddress = new ContractB();
        vm.stopBroadcast();
        address proxy = upgradeAddress(mostRecentlyDeployedProxy, address(newaddress));
        return proxy;
    }

    function upgradeAddress(address _proxyAddress, address _newaddress) public returns (address) {
        vm.startBroadcast();
        ContractA proxy = ContractA(payable(_proxyAddress));
        proxy.upgradeToAndCall(address(_newaddress),"");
        vm.stopBroadcast();
        return address(proxy);
    }

}
