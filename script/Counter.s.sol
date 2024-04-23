// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.23;

import {Script, console} from "forge-std/Script.sol";
import {Counter} from "../src/Counter.sol";

contract CounterScript is Script {

    Counter public counter;

    function setUp() public {}

    function run() public {
       // vm.broadcast();
        uint privateKey = vm.envUint("PRIVATE_KEY");

        vm.createSelectFork(vm.rpcUrl("sepolia"));
        vm.startBroadcast(privateKey);
        counter = new Counter();
        counter.setNumber(123456);
        counter.increment();
        vm.stopBroadcast();
    }
}
