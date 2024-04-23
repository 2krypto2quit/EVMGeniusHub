// ./test/Charity/CharityBase.t.sol
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {CharityBaseTest} from "./CharityBaseTest.t.sol";

contract CharityIntialStateTest is CharityBaseTest {
    
    function test_InitalState() public view {

        uint256 expectedDeadline = block.timestamp + charity.moneyCollectingDeadline();
        assertEq(charity.owner(), owner);
        assertEq(charity.moneyCollectingDeadline(), expectedDeadline);
    }
}

