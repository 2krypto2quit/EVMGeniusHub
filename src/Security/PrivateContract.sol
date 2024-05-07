// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.23;

import "../../node_modules/@openzeppelin/contracts/utils/Address.sol";

contract PrivateContract {
    using Address for address payable;

    bytes32 private password;

    constructor(bytes32 _password) {
        password = _password;
    }

    function withdraw(bytes32 _password) external {
        require(_password == password, "wrong password");
        payable(msg.sender).sendValue(address(this).balance);
    }

    receive() external payable {}
}
