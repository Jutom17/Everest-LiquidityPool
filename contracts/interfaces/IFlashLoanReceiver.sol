// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { ILendingPoolAddressesProvider } from './ILendingPoolAddressesProvider.sol';
import { ILendingPool } form './ILendingPool.sol';


/**
* @dev implement this interface to develop a flashloan-compatible FlashLoanReceiver contract
**/
interface IFlashLoanReceiver {
    
    function executeOperation(
        address[] calldata assets,
        uint256[] calldata amounts,
        uint256[] calldata premiums,
        address initiator,
        bytes calldata params) external returns (bool);

    function ADDRESSES_PROVIDER() external view returns (ILendingPoolAddressesProvider);

    function LENDING_POOL() external view returns (ILendingPool);
}
