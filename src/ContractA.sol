// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {OwnableUpgradeable} from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import {UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";

contract ContractA is Initializable, OwnableUpgradeable, UUPSUpgradeable {

   uint256 public amount;

   //disable any initialization during contract deployment.
   constructor() {
      _disableInitializers();
   }

   //Proxies don’t use constructors, so we use the initializer function to set the owner
     function initialize() public initializer {
        __Ownable_init(msg.sender); //sets owner to msg.sender
        __UUPSUpgradeable_init();
    }
    function initialAmount(uint _amount) public returns(uint){
        amount = _amount;
        return amount;
    }

    function inc(uint _amount) public returns (uint){
        amount = _amount + 10;
        return amount;
    }

    // Only the proxy admin can upgrade the contract
    function _authorizeUpgrade(address newImplementation) internal override onlyOwner {}
         
}