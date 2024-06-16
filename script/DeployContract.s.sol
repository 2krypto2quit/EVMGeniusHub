// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
import {Script} from "forge-std/Script.sol";
import {ContractA} from "../src/ContractA.sol";
import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";

contract DeployContractA  is Script {

    function run() external returns (address) {
        address proxy = deployContractA();
        return proxy;
    }

    function deployContractA() public returns (address) {
        vm.startBroadcast();
        ContractA contractA = new ContractA(); //Our implementation(logic).Proxy will point here to delegate call/borrow the functions
        ERC1967Proxy proxy = new ERC1967Proxy(address(contractA), ""); //Our proxy will point to our implementation
        vm.stopBroadcast();
        return address(proxy);
    }
}