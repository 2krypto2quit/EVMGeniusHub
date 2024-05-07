// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.23;

import "../../node_modules/@openzeppelin/contracts/utils/Address.sol";

contract Wallet {
    using Address for address payable;

    mapping(address => uint256) public balances;

    function deposit() external payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw() external {
        require(balances[msg.sender] > 0);
        payable(msg.sender).sendValue(balances[msg.sender]);
        balances[msg.sender] = 0;
    }
}
