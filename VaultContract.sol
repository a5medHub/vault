// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.15;

contract VaultContract{
    struct Vault{
        address creator;
        string name;
        address[] users;
        uint amount;

    }
