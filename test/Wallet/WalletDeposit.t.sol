// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.23;

import {Test} from "forge-std/Test.sol";
import {Wallet} from "../../src/Wallet.sol";
import {WalletBaseTest} from "./WalletBaseTest.t.sol";

contract WalletDepositTest is WalletBaseTest {
    /*
        Donate:
        Test donate with donation - happy path
        Test donate without donation - happy path
        Test can not deposit zero ethers - unhappy path
    */

    function test_Deposit_WithDonation() public {
        uint256 expectedDonateAmount = (depositAmount * charityPercentage) / 1000;
        uint256 expectedDepositAmount = depositAmount - expectedDonateAmount;

        _deposit(address(this), depositAmount);

        assertEq(address(charity).balance, expectedDonateAmount);
        assertEq(address(wallet).balance, expectedDepositAmount);
    }

    function test_Deposit_WithoutDonation() public {
        uint256 expectedDonateAmount = 0;
        uint256 expectedDepositAmount = depositAmount;
        uint256 charityDeadline = charity.moneyCollectingDeadline();
        vm.warp(charityDeadline);

        _deposit(address(this), depositAmount);

        assertEq(address(charity).balance, expectedDonateAmount);
        assertEq(address(wallet).balance, expectedDepositAmount);
    }

    function test_RevertWhen_CanNotDepositZeroEthers() public {
        vm.expectRevert(Wallet.CanNotDepositZeroEthers.selector);

        _deposit(address(this), 0);
    }
}
