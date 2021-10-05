// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


/**
* @dev implement this interface to develop a flashloan-compatible FlashLoanReceiver contract
**/
interface IFlashLoanReceiver {
    
    function executeOperation(address _reserve, uint256 _amount, uint256 _fee, bytes calldata _params) external;
}
