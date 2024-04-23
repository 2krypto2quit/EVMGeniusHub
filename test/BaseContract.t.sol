// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.23;

import {Test} from "forge-std/Test.sol";
import {BaseContract} from "../src/BaseContract.sol";

contract BaseContractTest is Test {

    BaseContract public baseContract;

    function setUp() public {
        baseContract = new BaseContract();
    }

    function test_InitalValues() public {
        
        //Arrange
        uint256 expectedValue = 1;

        //Assert
        uint256 currentArryNumber = baseContract.array(0);
        uint256 currentSimpleNumber = baseContract.simpleMapping(0);
        uint256 currentNestedMapping = baseContract.nestedMapping(0,0);

        assertTrue(currentArryNumber == expectedValue);
        assertTrue(currentSimpleNumber == expectedValue);
        assertEq(currentNestedMapping, expectedValue);
    }

    function test_Increment() public  {

        //Arrange
        uint256 expectedValue = 1;

        //Act
        baseContract.increment();

        //Assert
        uint256 currentNumber = baseContract.number();
        assert(currentNumber == expectedValue);
        
    }

}


