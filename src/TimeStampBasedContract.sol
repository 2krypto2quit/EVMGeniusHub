// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.23;


contract TimeStampBasedContract {

    uint256 public number;
    uint256 public minTimestamp;

    error NotMinimumTimeStampReaced(uint256 currentTimeStamp, uint256 requiredTimeStamp);

    constructor(uint256 _minTimestamp) {
        minTimestamp = _minTimestamp;
    }

    function setNumber(uint256 newNumber) external {

        if(block.timestamp < minTimestamp) {
            revert NotMinimumTimeStampReaced(block.number, minTimestamp);
        }

        number = newNumber;

    }
}