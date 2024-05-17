// Layout of Contract:
// version
// imports
// errors
// interfaces, libraries, contracts
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

//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {VRFCoordinatorV2Interface} from "src/interfaces/VRFCoordinatorV2Interface.sol";
import {VRFConsumerBaseV2} from "src/interfaces/VRFConsumerBaseV2.sol";
import {AutomationCompatibleInterface} from "src/interfaces/AutomationCompatibleInterface.sol";

/// @title A simple raffle contract
/// @notice This contractn is a simple raffle contract that allows users to buy tickets and win prizes
/// @dev Implements Chainlink VRF for random number generation.
/// @author  Kevin Matthews

contract Raffle is VRFConsumerBaseV2 {
    error RaffleContract_NotEnoughEthSent();
    error RaffleContract_TrasnferFailed();
    error RaffeContract_RaffleNotOpen();
    error RaffleContract_UpkeepNotNeeded(
        uint256 balance,
        uint256 players,
        uint256 state
    );

    enum RaffleState {
        OPEN,
        CALCULATING_WINNER
    }

    //** State Variables */
    uint16 private constant REQUEST_CONFIRMATIONS = 3;
    uint32 private constant NUM_OF_WORDS = 1;

    uint256 private immutable i_entranceFee;
    // @dev Duration of the raffle in seconds
    uint256 private immutable i_interval;
    uint32 private immutable i_callbackGasLimit;
    VRFCoordinatorV2Interface private immutable i_vrfCoordinator;
    bytes32 private immutable i_gasLane;
    uint64 private immutable i_subscriptionId;
    address private s_recentWinner;
    address payable[] private s_players;
    uint256 private s_lastTimeStamp;
    RaffleState private s_raffleState;

    event EnteredRaffle(address indexed player);
    event WinnerPicked(address indexed winner);
    event RequestedRaffleWinner(uint256 indexed requestId);

    constructor(
        uint256 ticketPrice,
        uint256 duration,
        address vrfCoordinator,
        bytes32 gasLane,
        uint32 callbackGasLimit,
        uint64 subscriptionId
    ) VRFConsumerBaseV2(vrfCoordinator) {
        i_entranceFee = ticketPrice;
        i_interval = duration;
        s_lastTimeStamp = block.timestamp;
        i_vrfCoordinator = VRFCoordinatorV2Interface(vrfCoordinator);
        i_gasLane = gasLane;
        i_subscriptionId = subscriptionId;
        i_callbackGasLimit = callbackGasLimit;
        s_raffleState = RaffleState.OPEN;
    }

    function enterRaffle() external payable {
        if (msg.value < i_entranceFee) {
            revert RaffleContract_NotEnoughEthSent();
        }

        if (s_raffleState != RaffleState.OPEN) {
            revert RaffeContract_RaffleNotOpen();
        }

        s_players.push(payable(msg.sender));
        emit EnteredRaffle(msg.sender);
    }

    /**
     * @dev This is the function that the Chainlink Keeper nodes call
     * they look for `upkeepNeeded` to return True.
     * the following should be true for this to return true:
     * 1. The time interval has passed between raffle runs.
     * 2. The lottery is open.
     * 3. The contract has ETH.
     * 4. Implicity, your subscription is funded with LINK.
     */

    function checkUpKeep(
        bytes memory /*checkData*/
    ) public view returns (bool upkeepNeeded, bytes memory /*performData */) {
        bool isOpen = s_raffleState == RaffleState.OPEN;
        bool timePassed = (block.timestamp - s_lastTimeStamp) > i_interval;
        bool hasPlayers = s_players.length > 0;
        bool hasBalance = address(this).balance > 0;
        upkeepNeeded = (timePassed && isOpen && hasBalance && hasPlayers);
        return (upkeepNeeded, "0x0");
    }

    /**
     * @dev Once `checkUpkeep` is returning `true`, this function is called
     * and it kicks off a Chainlink VRF call to get a random winner.
     */
    function performUpkeep(bytes calldata /* performData */) external {
        (bool upkeepNeeded, ) = checkUpKeep("");
        if (!upkeepNeeded) {
            revert RaffleContract_UpkeepNotNeeded(
                address(this).balance,
                s_players.length,
                uint256(s_raffleState)
            );
        }

        // Request a random number to represent the winner
        s_raffleState = RaffleState.CALCULATING_WINNER;

        uint256 requestId = i_vrfCoordinator.requestRandomWords(
            i_gasLane,
            i_subscriptionId,
            REQUEST_CONFIRMATIONS,
            i_callbackGasLimit,
            NUM_OF_WORDS
        );

        emit RequestedRaffleWinner(requestId);
    }

    function fulfillRandomWords(
        uint256 /* requestId */,
        uint256[] memory randomness
    ) internal override {
        //Checks
        //Effects
        uint256 indexOfWinner = randomness[0] % s_players.length;
        address payable winner = s_players[indexOfWinner];
        s_recentWinner = winner;
        s_raffleState = RaffleState.OPEN;
        s_players = new address payable[](0);
        s_lastTimeStamp = block.timestamp;

        emit WinnerPicked(winner);

        //Interactions
        (bool success, ) = winner.call{value: address(this).balance}("");
        if (!success) {
            revert RaffleContract_TrasnferFailed();
        }
    }

    /** Getter Functions */
    function getEntranceFee() external view returns (uint256) {
        return i_entranceFee;
    }
}
