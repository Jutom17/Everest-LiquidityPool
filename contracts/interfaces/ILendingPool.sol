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

    /**
    * @dev Emitted on borrow()
    * @param asset - The address of the underlying asset being borrowed
    * @param user - The address of the user initiating the borrow()
    * @param amount - The amount borrowed out
    **/
    event Borrow(
        address user,
        address indexed asset,
        uint256 amount
    );

    /**
    * @dev Emitted on repay()
    * @param asset - The address of the underlying asset
    * @param user - The address of the user initiating the repay() 
    * @param amount - The amount repaid
    **/
    event Repay(
        address indexed user,
        address indexed asset,
        uint256 amount
    );

}
