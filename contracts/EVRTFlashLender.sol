// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./IEVRTFlashBorrower.sol";
import "./standards/SafeMath.sol";
import "./standards/Ownable.sol";
import "./standards/ReentrancyGuard.sol";
import "./standards/IERC20.sol";

// @notice Any contract that inheritis this contract becomes a flash lender of any 
//         ERC20 tokens that it has whitelisted.
contract EVRTFlashLender is Ownable, ReentrancyGuard {
    using SafeMath for uint256;

    uint256 internal _tokenBorrowFee = 0.001e18; // fee at 0.1%
    uint256 constant internal ONE = 1e18;


    // only whitelist tokens whose 'transferFrom' function returns false (or reverts)
    // on failure
    mapping(address => bool) internal _whitelist;

    // @notice Borrow tokens via a flash loan
    function EVRTFlashLoan(address token, uint256 amount) external {
        // Token must be whitelisted by lender
        //require(_whitelist[token], "token not whitelisted");

        // record debt
        uint256 debt = amount.mul(ONE.add(_tokenBorrowFee)).div(ONE);

        // send borrower the tokens
        require(IERC20(token).transfer(msg.sender, amount), "borrow failed");

        // Hand over control to borrower
        IEVRTFlashBorrower(msg.sender).executeOnEVRTFlashLoan(token, amount, debt);

        // repay the dept

        require(IERC20(token).transferFrom(msg.sender, address(this), debt), "repayment failed");
    }

    function tokenBorrowFee() public view returns(uint256) {
        return _tokenBorrowFee;
    }
}
