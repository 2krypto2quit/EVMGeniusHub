// ./test/Charity/CharityWithdraw.t.sol
// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.23;

import {Test} from "forge-std/Test.sol";
import {Charity} from "../src/Charity.sol";
//import {FakeOwner} from "../src/FakeOwner.sol";
import {CharityBaseTest} from "./CharityBaseTest.t.sol";

contract CharityWithDrawTest is CharityBaseTest {

      /*
        Withdraw:
        Test withdraw - happy path
        Test when not owner - unhappy path
        Test when not enough money - unhappy path
        Test when transfer failed - unhappy path
    */

    function setUp() public override {
        super.setUp();
        deal(address(charity), donationAmount);
    }

    function test_Withdraw() public {
        uint256 expectedDonatedAmount = donationAmount;
        vm.expectEmit(true, true, true, true);
        emit WithDrawn(expectedDonatedAmount);

        _withdrawn(owner, expectedDonatedAmount);

        assertEq(address(charity).balance, 0);
        assertEq(owner.balance, expectedDonatedAmount);
    }

    function test_RevertWhen_NotOwner() public {
        vm.expectRevert(Charity.NotOwner.selector);
        _withdrawn(address(this), donationAmount);
    }

    function test_RevertWhen_NotEnoughMoney() public {
        vm.expectRevert(Charity.NotEnoughMoney.selector);
        _withdrawn(owner, donationAmount + 1);
    }

}
