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
    function addAmount(uint vaultId, uint amount) public{
        Vault storage vault = vaults[vaultId];
        require(msg.sender == vault.creator, "NOT THE OWNER");
        vault.amount += amount;
    }

    function distribute(uint vaultId) public{
        Vault storage vault = vaults[vaultId];
        uint amoutPerUser = vault.amount/vault.users.length;
        require(msg.sender == vault.creator, "NOT THE OWNER");
        if(vault.amount !=0 ){
            for(uint8 i; i < vault.users.length; i++){
                vault.amount -= amoutPerUser;
                balance[vault.users[i]] = amoutPerUser;
            }
        }else{
            revert("NO FUNDS AVAIABLE!!");
        }
        emit VaultDistrubtion(vaultId, amoutPerUser * vault.users.length);
    }

}
