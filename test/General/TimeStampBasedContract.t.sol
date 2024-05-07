// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.23;

import {Test} from "forge-std/Test.sol";
import {TimeStampBasedContract} from "../../src/TimeStampBasedContract.sol";

contract TimeStampBased is Test {
    TimeStampBasedContract public timestampedBasedContract;

    uint256 minTimestamp = 1714514400;

    function setUp() public {
        timestampedBasedContract = new TimeStampBasedContract(minTimestamp);
    }

    function test_SetNumber() public {
        uint256 newNumber = 10;
        vm.warp(minTimestamp);
        timestampedBasedContract.setNumber(newNumber);

        assertEq(timestampedBasedContract.number(), newNumber);
    }
}
