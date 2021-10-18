// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


interface ILendingPoolCore {
    /**
    * @dev Emitted on deposit()
    * @param user - The address initiating the deposit
    * @param amount - The amount deposited
    **/
    event Deposit(
        address user,
        uint256 amount
    );

    /**
    * @dev Emitted on withdraw()
    * @param user - The address initiating the withdrawal
    * @param amount - The amount to be withdrawn
    **/
    event Withdraw(
        address indexed user, 
        uint256 amount
    );
    
    //function deposit(address _token, uint256 _amount) external {}

    
    //function withdraw(uint256 _amount) external {}
}
