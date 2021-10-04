// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./EVRTFlashLender.sol";
import "./standards/Ownable.sol";
import "./standards/IERC20.sol";
import "./standards/SafeMath.sol";


// @notice Used by borrower to flash-borrow ERC20 tokens from ERC20FlashLender
contract EVRTFlashBorrower is Ownable {
    using SafeMath for uint256;
    uint256 arbVal;

    // Set the Lender contract address to a trusted ERC20FlashLender
    EVRTFlashLender public constant evrtFlashLender = EVRTFlashLender(address(0x5FcFa3d0419271A7a4E25984654420445e0DCCf6));

    // @notice Borrow anyERC20 token that the ERC20FlashLender holds
    function borrow(address token, uint256 amount) public onlyOwner {
        evrtFlashLender.EVRTFlashLoan(token, amount);    
    }

    // This is called by ERC20FlashLender after borrower has received the tokens
    // every ERC20FlashBorrower must implement an 'executeOnEVRTFlashLoan' function.
    function executeOnEVRTFlashLoan(address token, uint256 amount, uint256 debt) external {
        require(msg.sender == address(evrtFlashLender), "only lender contract can execute");

        // Do whatever you want 

        // authorize loan repayment
        IERC20(token).approve(address(evrtFlashLender), debt);
    }
}
