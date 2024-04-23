// ./test/Charity/CharityBase.t.sol
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {Charity} from "../src/Charity.sol";


abstract contract CharityBaseTest is Test {
    Charity charity;

    uint256 public moneyCollectionDeadline = 10 days;
    //make notes
    address owner = address(1);
    address donator = address(2);
    uint256 donationAmount = 1 ether;

    event Donated(address indexed donator, uint256 amount);
    event WithDrawn(uint256 amount);

    function setUp() public virtual {

        charity = new Charity(owner, moneyCollectionDeadline);

    }

    function _dontate(address from, uint256 amount) internal {
        //make notes
        vm.prank(from);
        charity.donate{ value: amount}();
    }

    function _withdrawn(address from, uint256 amount) internal {
        vm.prank(from);
        charity.withdraw(amount);
    }
}