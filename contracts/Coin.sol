pragma solidity ^0.8.4;

contract Coin {
    //public keyword makes variables
    //accessible from other contracts.
    address public minter;
    mapping(address => uint) public balances;

    event Sent(address from, address to, uint amount);
    
    //constructor code only runs when the contract is created.
    constructor() {
        minter = msg.sender;
    }

    //sends amount of coins to an address
    //can only be called by the contract creator
    function mint(address receiver, uint amount) public {
        require(msg.sender == minter);
        balances[receiver] += amount;
    }

    //returns to the caller function and informs
    //why operation fails.
    error InsufficientBalance(uint requested, uint available);
    
    /// Sends an amount of existing coins
    // from any caller to an address
    function send(address receiver, uint amount) public {
        if(amount > balances[msg.sender])
            revert InsufficientBalance({
                requested:amount,
                available:balances[msg.sender];
            });
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        emit Sent(msg.sender, receiver, amount);
    }

}