// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { ILendingPoolCore } from "./interfaces/ILendingPoolCore.sol";
import { SafeMath } from "../libraries/SafeMath.sol";
import { IERC20 } from "../libraries/IERC20.sol";
import { ERC20 } from "../libraries/ERC20.sol";
import { SafeERC20 } from "../libraries/SafeERC20.sol";


contract LendingPool is ILendingPoolCore, ERC20 {
    using SafeMath for uint256;
    using SafeERC20 for IERC20;
        
    IERC20 public poolToken;

    struct Account {
        uint256 balance;
        uint256 isFirstDeposit;
    }

    // mapping of user address -> balance 
    mapping(address => Account) private _balances;
    uint256 public _poolTokenSupply;

    constructor(
        string memory name,
        string memory symbol,
        IERC20  _poolToken 
    ) ERC20(name, symbol) { 
        poolToken = _poolToken;
    }

    // ========= VIEWS ========= //
    function poolTokenBalance() public view returns(uint256) {
        return poolToken.balanceOf(address(this));
    }

    
    function deposit(uint256 _amount) external { 
        require(_amount > 0, "Can't deposit 0");

        uint256 totalAmount = _amount * ether;

        // mint it 1:1 to the amount put in
        _mint(msg.sender, totalAmount);

        uint256 isFirstDeposit = _balances[msg.sender].isFirstDeposit;
        
        if (isFirstDeposit == 0) {
            // get fee
            // set first deposit to false
            _balances[msg.sender].isFirstDeposit = 1; 
        } 

        // Updates User balance
        _balances[msg.sender].balance = _balances[msg.sender].balance.add(totalAmount);
        
        // Update total deposited in the pool
        _poolTokenSupply = _poolTokenSupply.add(totalAmount);
        
        // Lock the poolToken in the contract
        poolToken.safeTransferFrom(msg.sender, address(this), totalAmount);
        emit Deposit(msg.sender, totalAmount);
    }

    // Claim back your poolToken.
    // Unlocks the amount deposited + gained and burns the eToken.
    function withdraw(uint256 _amount) external { 
        // Check to see if user has enough funds, and amount > 0
        require(_balances[msg.sender].balance >= _amount && _amount > 0); 
        
        uint256 totalAmount = _amount * ether;

        // Updates User balance
        _balances[msg.sender].balance = _balances[msg.sender].balance.sub(totalAmount);   
        _poolTokenSupply = _poolTokenSupply.sub(totalAmount);
        
        // burn eToken
        _burn(msg.sender, totalAmount);
        poolToken.safeTransfer(msg.sender, totalAmount);
        

        emit Withdraw(msg.sender, totalAmount);
    }

}
