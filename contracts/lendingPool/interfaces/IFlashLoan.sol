// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC20 } from "../../libraries/IERC20.sol";

abstract contract IFlashLoan {

    function executeFlashLoan(IERC20 token, uint256 amount, uint256 debt) external returns(bool) {
        require(msg.sender == address(this), "Only contract can execute flashLoan");

        // Your logic goes here.

        // authoraize loan payment
        token.approve(address(this), debt);
        return true;
    }
}