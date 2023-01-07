// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ChildContract {
    struct ContractDetails {
        bytes32 salt;
        address owner;
    }
    bytes32 public salt;

    mapping(uint256 => ContractDetails) public contracts;
    uint256 constant id = 0;

    constructor(ContractDetails memory CD, bytes32 _salt) payable {
        CD = contracts[id];
        salt = _salt;
    }
}
