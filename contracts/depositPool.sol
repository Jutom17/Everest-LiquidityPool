// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./EVRTFlashLender.sol";
import "./standards/ReentrancyGuard.sol";


// ERC20 Flashlan 
contract depositPool is EVRTFlashLender {
    // set the Lender contract address to a trusted flashmodule contract
    uint public totalfees; // total fees collected till now
    mapping(address => uint256) public balances;

    constructor() public {
    
    }

    function deposit(address token, address onBehalfOf, uint256 amount) public {
        IERC20(token).transferFrom(onBehalfOf, address(this), amount);
    }

    function withdraw(address token, address onBehalfOf) public {
        IERC20(token).transfer(onBehalfOf, IERC20(token).balanceOf(address(this)));
    }


    /*
    * @dev allows smart contracts to access the liquidity of the pool within one 
    * transaction, as long as the amount taken plus a fee is returned.
    */


}
