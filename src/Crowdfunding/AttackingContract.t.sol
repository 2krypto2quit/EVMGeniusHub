// src/AttackingContract.t.sol
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.23;

import "forge-std/Test.sol";
import {AttackingContract} from "src/Crowdfunding/AttackingContract.sol";
import {DecentralizedCrowdFunding} from "src/Crowdfunding/DecentralizedCrowdFunding.sol";

contract AttackingContractTest is Test {
    AttackingContract public attackingContract;
    DecentralizedCrowdFunding public decentralizedCrowdFunding;

    uint256 legalContribution = 10 ether;
    uint256 legalGoal = 20 ether;
    uint256 legalDuration = 1 days;

    uint256 attackingContribution = 1 ether;
    uint256 attackingGoal = 2 ether;
    uint256 attackingDuration = 30 minutes;
    uint256 attackingDeadline = block.timestamp + attackingDuration;

    function setUp() public {
        decentralizedCrowdFunding = new DecentralizedCrowdFunding();
        attackingContract = new AttackingContract(address(decentralizedCrowdFunding));
    }

    // function test_RevertIf_CheckEffectInteractionsIsPresent() public {
    //     // Legal actions, which will rise some amount to withdraw by attacker
    //     decentralizedCrowdFunding.createCampaign(legalGoal, legalDuration);
    //     decentralizedCrowdFunding.contribute{value: legalContribution}(decentralizedCrowdFunding.numCampaigns());

    //     attackingContract.prepareAttack{value: attackingContribution}(attackingGoal, attackingDuration);
    //     vm.warp(attackingDeadline);
    //     vm.expectRevert(DecentralizedCrowdFunding.TransferFailed.selector);
    //     attackingContract.attack();
    // }
}
