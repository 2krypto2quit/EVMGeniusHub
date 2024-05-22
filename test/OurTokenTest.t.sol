// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {DeployOurToken} from "../script/DeployOurToken.s.sol";
import {OurToken} from "../src/OurToken.sol";
import {Test, console} from "forge-std/Test.sol";
import {StdCheats} from "forge-std/StdCheats.sol";

interface MintableToken {
    function mint(address, uint256) external;
}

contract OurTokenTest is  StdCheats, Test {

    uint256 BOB_STARTING_AMOUNT = 1 ether;

    OurToken public ourToken;
    DeployOurToken public deployer;
    address public deployerAddress;
    address bob;
    address alice;

    function setUp() public {

        deployer = new DeployOurToken();
        ourToken = deployer.run();     

        bob = makeAddr("bob");
        alice = makeAddr("alice");

        deployerAddress = vm.addr(deployer.deployerKey());

        uint256 tokenBalance = ourToken.balanceOf(deployerAddress); 

        //Make sure the transfer amount does not execeed the available balance
        uint256 adjustStartingAmount = ourToken.totalSupply() / 2;
        console.log("Token Balance", adjustStartingAmount);
    
        vm.prank(deployerAddress);
        //console.log(BOB_STARTING_AMOUNT);
        ourToken.transfer(bob, BOB_STARTING_AMOUNT);
    }

     function testInitialSupply() public {
        assertEq(ourToken.totalSupply(), deployer.INITIAL_SUPPLY());
    }

    function testUsersCantMint() public {
        vm.expectRevert();
        MintableToken(address(ourToken)).mint(address(this), 1);
    }

    function testAllowances() public {
        uint256 initialAllowance = 1000;

        // Alice approves Bob to spend tokens on her behalf
        vm.prank(bob);
        ourToken.approve(alice, initialAllowance);
        uint256 transferAmount = 500;

        vm.prank(alice);
        ourToken.transferFrom(bob, alice, transferAmount);
        assertEq(ourToken.balanceOf(alice), transferAmount);
        assertEq(ourToken.balanceOf(bob), BOB_STARTING_AMOUNT - transferAmount);
    }

    function testBobBalance() public {
        assertEq(ourToken.balanceOf(bob), BOB_STARTING_AMOUNT);
    }

   

}