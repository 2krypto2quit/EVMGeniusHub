// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.23;

import {Test} from "forge-std/Test.sol";
import {Wallet} from "../../src/Wallet.sol";
import {WalletBaseTest} from "./WalletBaseTest.t.sol";
import {FakeOwner} from "../../src/FakeOwner.sol";

contract WalletWithdrawTest is WalletBaseTest {
    /*
        Withdraw:
        Test withdraw - happy path
        Test when not owner - unhappy path
        Test when not enough money - unhappy path
        Test when transfer failed - unhappy path
    */

    function setUp() public override {
        super.setUp();
        deal(address(wallet), depositAmount);
    }

    function test_Withdraw() public {
        uint256 expectedWithDrawAmount = address(wallet).balance;

        _withdraw(owner, expectedWithDrawAmount);

        assertEq(address(wallet).balance, 0);
        assertEq(owner.balance, expectedWithDrawAmount);
    }

    function test_RevertWhen_NotOwner() public {
        vm.expectRevert(Wallet.NotOwner.selector);
        _withdraw(address(this), 0);
    }

    function test_RevertWhen_NotEnoughMoney() public {
        vm.expectRevert(Wallet.NotEnoughMoney.selector);
        _withdraw(owner, depositAmount + 1);
    }

    function test_RevertWhen_TransferFailed() public {
        FakeOwner fakeowner = new FakeOwner();
        wallet = new Wallet(address(fakeowner), address(charity), charityPercentage);

        deal(address(wallet), depositAmount);

        vm.expectRevert(Wallet.TransferFailed.selector);
        _withdraw(address(fakeowner), address(wallet).balance);
    }
}
