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
        
    IERC20 public immutable poolToken;

    // mapping of user address -> balance 
    mapping(address => uint256) private _balances;
    uint256 public _poolTokenSupply;

    constructor(
        string memory name,
        string memory symbol,
        address _poolToken 
    ) ERC20(name, symbol) { 
        poolToken = IERC20(_poolToken);
    }
    
    function deposit(uint256 _amount) external {
        require(_amount > 0, "Can't deposit 0");

        // Updates User balance
        _balances[msg.sender] = _balances[msg.sender].add(_amount);
        
        // Update total deposited in the pool
        _poolTokenSupply = _poolTokenSupply.add(_amount);

        poolToken.safeTransferFrom(msg.sender, address(this), _amount);

        // Mint and give user corresponding eToken values.
        _mint(msg.sender, _amount);
        //eToken.safeTransfer(msg.sender, _amount);

        emit Deposit(msg.sender, _amount);
    }


    function withdraw(uint256 _amount) external { 
        // Check to see if user has enough funds, and amount > 0
        require(_balances[msg.sender] >= _amount && _amount > 0);
          
        // Updates User balance
        _balances[msg.sender] = _balances[msg.sender].sub(_amount);  
        _poolTokenSupply = _poolTokenSupply.sub(_amount);

        // burn eToken
        _burn(msg.sender, _amount);
        poolToken.safeTransfer(msg.sender, _amount);

        emit Withdraw(msg.sender, _amount);
    }

}
