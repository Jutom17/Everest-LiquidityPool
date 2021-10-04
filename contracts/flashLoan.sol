// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./EVRTFlashBorrower.sol";
import "./standards/ReentrancyGuard.sol";

// ERC20 Flashloan
contract flashloan is EVRTFlashBorrower {
    uint256 public totalfees; // total fees collected til now
    mapping(address => bool) public _whitelist;
    mapping(address => uint256) public balances;



    function withdraw(address token, address onBehalfOf) public {
        IERC20(token).transfer(onBehalfOf, IERC20(token).balanceOf(address(this)));
    }

}
