// ./test/Charity/CharityBase.t.sol
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {Charity} from "../src/Charity.sol";
import {CharityBaseTest} from "./CharityBaseTest.t.sol";

contract CharityDontate is CharityBaseTest {

    function test_Donate() public {

        uint256 expectedDonatedAmount = donationAmount;
        vm.expectEmit(true, true, true, true);
        emit Donated(donator, expectedDonatedAmount);

        //make notes
        deal(donator, expectedDonatedAmount);
        _dontate(address(donator), expectedDonatedAmount);

        assertEq(address(charity).balance, expectedDonatedAmount);
        assertEq(charity.userDonations(donator), expectedDonatedAmount);
    }

    function test_RevertWhen_CanNotDonateAnymore() public {
        
        uint256 deadlineTimestamp = charity.moneyCollectingDeadline();

        vm.expectRevert(Charity.CanNotDonateAnymore.selector);
        vm.warp(deadlineTimestamp);

        _dontate(address(this), 0);

    }

    function test_RevertWhen_NotEnoughDonationAmount() public {
        vm.expectRevert(Charity.NotEnoughDonationAmount.selector);
        _dontate(address(this), 0);
    }

}


