// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.15;

contract VaultContract{
    struct Vault{
        address creator;
        string name;
        address[] users;
        uint amount;

    }
    uint totalVaults = 0;
    mapping(uint => Vault) public vaults;
    mapping(address => uint) public balance;

    event VaultDistrubtion(uint vaultId, uint amount);

    function createVault(
        string memory name,
        address[] memory users,
        uint initialAmount
    ) public returns (uint vaultId){
        Vault storage vault = vaults[totalVaults];
        vault.creator = msg.sender;
        vault.name = name;
        vault.users = users;
        vault.amount = initialAmount;

        totalVaults += 1;
        return totalVaults - 1;
    }
