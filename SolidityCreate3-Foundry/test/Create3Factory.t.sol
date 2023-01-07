// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.15;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../src/Create3Factory.sol";

contract Create3Factory is Test {
    ContractFactory public contractFactory;

    function setUp() public {
        contractFactory = new ContractFactory();
    }

    function testDeploy() public {
        address deploy = contractFactory.deploy{value: 2 ether}("Jesserc");
        console.log("New child contract address", deploy);
        // assertEq(contractFactory.number(), 1);
    }

    function testGetDeployed() public {
        contractFactory.getDeployed("Jesserc");
        assertEq(
            contractFactory.getDeployed("Jesserc"),
            0x223c482Be6217a0566DB5454F034996ED7ecd7F6
        );
    }

    function testVerifyDeployed() public {
        //0x223c482Be6217a0566DB5454F034996ED7ecd7F6
        address deploy = contractFactory.deploy{value: 2 ether}("Jesserc");

        contractFactory.verifyDeployed("Jesserc", deploy);

        bytes32 salt = keccak256(abi.encodePacked("Jesserc"));
        console.log("Salt for child contract is");
        console.logBytes32(salt);

        assertEq(
            salt,
            0xf9755126fc063f2efa34b154637fbc7fc7c598bb68ab1b00b0c5113588c6ac64
        );
    }
}
