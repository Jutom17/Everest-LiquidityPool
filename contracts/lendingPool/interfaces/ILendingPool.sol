// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;


interface ILendingPool {
    /**
    * @dev Emitted on deposit()
    * @param asset - The address of the underlying asset of the reserve
    * @param user - The address initiating the deposit
    * @param amount - The amount deposited
    **/
    event Deposit(
        address user,
        address indexed asset,
        uint256 amount
    );

    /**
    * @dev Emitted on withdraw()
    * @param asset - The address of the underlyng asset being withdrawn
    * @param user - The address initiating the withdrawal
    * @param amount - The amount to be withdrawn
    **/
    event Withdraw(
        address indexed user, 
        address indexed asset, 
        uint256 amount
    );
}
