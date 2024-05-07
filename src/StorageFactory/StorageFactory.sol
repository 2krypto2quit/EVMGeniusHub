// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.23;

import {SimpleStorage} from "./SimpleStorage.sol";

contract StorageFactory {
    SimpleStorage[] public listOfSimpleStorageContracts;

    function createSimpleStorageContract() public {
        //Create a new instance of the simple storage contract
        SimpleStorage simpleStorageContractVariable = new SimpleStorage();
        listOfSimpleStorageContracts.push(simpleStorageContractVariable);
    }

    function sfStore(uint256 _simplestorageIndex, uint256 _simpleStorageNumber) public {
        //Address
        //ABI
        //
        listOfSimpleStorageContracts[_simplestorageIndex].store(_simpleStorageNumber);
    }

    function sfGet(uint256 _simpleStorageIndex) public view returns (uint256) {
        return listOfSimpleStorageContracts[_simpleStorageIndex].retrieve();
    }
}
