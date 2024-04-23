// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.23;

contract Counter {
    uint256 public number;
    uint256 public newVariable;

    function setNumber(uint256 newNumber) public {
        number = newNumber;
    }

    function increment() public {
        number++;
    }
}
