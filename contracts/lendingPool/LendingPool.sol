// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

import { ILendingPool } from '../interfaces/ILendingPool.sol';
import { IERC20 } from "../libraries/IERC20.sol";
import { SafeERC20 } from "../libraries/SafeERC20.sol";

/**
 * @title LendingPool contract
 * @dev Users can:
 *      # Deposit
 *      # Withdraw
 *      # Borrow
 *      # Repay
 **/
contract LendingPool is ILendingPool {
    using SafeERC20 for IERC20; 
   
    // mapping of user address -> (asset addresses -> amount of respective asset) 
    mapping(address => mapping(address => uint256)) private UserDeposits;
    
    // mapping for each asset address and its total amount in the pool
    mapping(address => uint256) public TotalPoolAssets; 
    

    /**
    * @dev Deposits an `amount` of underlying asset into the pool.
    * @ param asset - The address of the underlying asset to deposit.
    * @ param amount - The amount to be deposited.
    **/
    function deposit(address _asset, uint256 _amount) external {
        // ToDo - update user Rates, acummulated Interest

        // Updates User deposit balance
        UserDeposits[msg.sender][_asset] = UserDeposits[msg.sender][_asset] + _amount;
        
        // Update total assets deposited in the pool
        TotalPoolAssets[_asset] = TotalPoolAssets[_asset] + _amount;

        emit Deposit(msg.sender, _asset, _amount);
    }

    /**
    * @dev Withdraws an `amount` of underlying asset from the pool.
    * @param asset - The address of tghe underlying asset to withdraw.
    * @param amount - The underlying amount to be withdrawn.
    **/
    function withdraw(address _asset, uint256 _amount) external {
        // ToDo - update user Rates, acummulated Interest
        
        // Check to see if user has enough funds  
        require(UserDeposits[msg.sender][_asset] >= _amount)
        
        // Updates User deposit balance
        UserDeposits[msg.sender][_asset] = UserDeposits[msg.sender][_asset] - _amount;
        
        // Subtract amount withdrawn from the total of the pool
        TotalPoolAssets[_asset] = TotalPoolAssets[_asset] - _amount;

        emit Withdraw(msg.sender, _asset, _amount);
    }

    /**
    * @dev Allows user to borrow a specific `amount` of the underlying asset,
    *    given that the user already deposited enough collateral.
    * @ param asset - The address of the underlying asset to borrow.
    * @ param amount - The amount to be borrowed.
    **/
    function borrow(address _asset, uint256 _amount) external {
        
        emit Borrow(msg.sender, _asset, _amount); 
    }

    /**
    * @notice Repays a borrowed `amount`.
    * @param asset - The address of the borrowed underlying asset previously borrowed.
    * @param amount - The amount to repay.
    **/
    function repay(address _asset, uint256 _amount) external {

        emit Repay(msg.sender, _asset, _amount);    
    }
