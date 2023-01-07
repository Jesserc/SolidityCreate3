# Solidity Create3 With Hardhat
`Create3` is a library in Solidity that allows developers to deploy contracts deterministically. Deterministic deployment means that the same contract can be deployed to multiple networks or addresses using the same bytecode and arguments, without requiring manual intervention or additional deployment steps. 

This can be useful for creating contracts that are intended to be deployed multiple times, or for creating contracts that are intended to be deployed to multiple locations with the same functionality. Create3 utilizes the CREATE2 opcode to achieve deterministic deployment, and provides a simple interface for developers to use in their Solidity code.
