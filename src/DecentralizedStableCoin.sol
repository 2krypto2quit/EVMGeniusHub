// SPDX-License-Identifier: MIT

// This is considered an Exogenous, Decentralized, Anchored (pegged), Crypto Collateralized low volitility coin

// Layout of Contract:
// version
// imports
// interfaces, libraries, contracts
// errors
// Type declarations
// State variables
// Events
// Modifiers
// Functions

// Layout of Functions:
// constructor
// receive function (if exists)
// fallback function (if exists)
// external
// public
// internal
// private
// view & pure functions

pragma solidity ^0.8.18;

import {ERC20Burnable, ERC20} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
/**
 * @title Decentralized Stable Coin
 * @dev This contract is a decentralized stable coin that is anchored to a fiat currency
 * @author Kevin Matthews
 * Collateral: Exogenous( ETH & BTC)
 * Minting: Algorithmic
 * Peg: Pegged to USD
 * This is the contract meant to be governed by DSCEngine. This contract is just the ERC20
 *  implementation of our stable coin system
 */

contract DecentralizedStableCoin is ERC20Burnable, Ownable {
    error DecentralizedStableCoinAmountMustBeMoreThanZero();
    error DeccentralizedStableCoinBurnAmountExceedsBalance();
    error DecntralizedStableCoinNotZeroAddress();

    constructor() ERC20("Decentralized Stable Coin", "DSC") Ownable(address(this)) {}

    function burn(uint256 amount) public override onlyOwner {
        uint256 balance = balanceOf(msg.sender);

        if (amount <= 0) {
            revert DecentralizedStableCoinAmountMustBeMoreThanZero();
        }

        if (balance < amount) {
            revert DeccentralizedStableCoinBurnAmountExceedsBalance();
        }

        super.burn(amount);
    }

    function mint(address to, uint256 amount) external onlyOwner returns (bool) {
        if (to == address(0)) {
            revert DecntralizedStableCoinNotZeroAddress();
        }

        if (amount <= 0) {
            revert DecentralizedStableCoinAmountMustBeMoreThanZero();
        }

        _mint(to, amount);
        return true;
    }
}