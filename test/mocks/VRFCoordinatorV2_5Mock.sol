//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {VRFConsumerBase} from "lib/chainlink-brownie-contracts/contracts/src/v0.8/VRFConsumerBase.sol";
import {LinkTokenInterface} from "lib/chainlink-brownie-contracts/contracts/src/v0.8/interfaces/LinkTokenInterface.sol";

contract VRFCoordinatorMock {
    LinkTokenInterface public LINK;

    event RandomnessRequest(
        address indexed sender,
        bytes32 keyHash,
        uint256 seed,
        uint256 fee
    );

    constructor(address _link) {
        LINK = LinkTokenInterface(_link);
    }

    function onTokenTransfer(
        address sender,
        uint256 fee,
        bytes memory _data
    ) public {
        (bytes32 keyHash, uint256 seed) = abi.decode(_data, (bytes32, uint256));
        emit RandomnessRequest(sender, keyHash, seed, fee);
    }

    function callBackWithRandomness(
        bytes32 requestId,
        uint256 randomness,
        address consumerContract
    ) public onlyLINK {
        VRFConsumerBase v;
        bytes memory resp = abi.encodeWithSelector(
            v.rawFulfillRandomness.selector,
            requestId,
            randomness
        );
        uint256 b = 206000;
        require(gasleft() > b, "not enough gas");
        (bool success, ) = consumerContract.call(resp);
    }

    modifier onlyLINK() {
        require(msg.sender == address(LINK), "Must use LINK token");
        _;
    }
}
