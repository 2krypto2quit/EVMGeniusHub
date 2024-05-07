// ./test/Charity/CharityWithdraw.t.sol
// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.23;

import {Test} from "forge-std/Test.sol";
import {Wallet} from "../../src/Wallet.sol";
import {WalletBaseTest} from "./WalletBaseTest.t.sol";

contract WalletInitialState is WalletBaseTest {
    function test_InitalState() public view {
        assertEq(wallet.owner(), owner);
        assertEq(address(wallet.charity()), address(charity));
    }
}
