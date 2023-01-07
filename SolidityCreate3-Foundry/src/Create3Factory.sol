// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Create3.sol";
import "./ChildContract.sol";

contract ContractFactory {
    struct ContractDetails {
        bytes32 salt;
        address owner;
    }

    function deploy(string memory salt)
        external
        payable
        returns (address deployed)
    {
        require(msg.value == 2 ether, "Deploy contract with two ether");
        bytes32 newSalt = keccak256(abi.encodePacked(salt));
        ContractDetails memory CD = ContractDetails({
            salt: newSalt,
            owner: msg.sender
        });

        deployed = Create3.create3(
            newSalt,
            abi.encodePacked(
                type(ChildContract).creationCode,
                abi.encode(CD, newSalt)
            ),
            msg.value
        );
    }

    function getDeployed(string memory salt)
        external
        view
        returns (address deployed)
    {
        bytes32 newSalt = keccak256(abi.encodePacked(salt));
        return Create3.addressOf(newSalt);
    }

    function verifyDeployed(string memory salt, address child)
        external
        view
        returns (bool status, bytes32 childSalt)
    {
        bytes32 newSalt = keccak256(abi.encodePacked(salt));
        childSalt = ChildContract(child).salt();

        if (newSalt == childSalt) {
            status = true;
        }

        return (status, childSalt);
    }
}
