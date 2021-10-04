// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IEVRTFlashBorrower {
    function executeOnEVRTFlashLoan(address token, uint256 amount, uint256 debt) external;
}
