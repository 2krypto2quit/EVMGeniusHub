// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.23;

import "../../node_modules/@openzeppelin/contracts/utils/Address.sol";
import "forge-std/console.sol";

contract Vault {
    using Address for address payable;

    address public owner;

    constructor() {
        owner = tx.origin;
    }

    function withdraw(address recipient) external {
        require(tx.origin == owner, "Not an owner");
        payable(recipient).sendValue(address(this).balance);
    }

    receive() external payable {}
}
