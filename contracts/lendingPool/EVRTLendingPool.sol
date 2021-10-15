// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

import { ILendingPoolCore } from "./interfaces/ILendingPoolCore.sol";
import { SafeMath } from "../libraries/SafeMath.sol";
import { IERC20 } from "../libraries/IERC20.sol";
import { SafeERC20 } from "../libraries/SafeERC20.sol";


contract EVRTLendingPool is ILendingPoolCore {
    using SafeMath for uint256;
    using SafeERC20 for IERC20;
        
    IERC20 public eEVRT;
    IERC20 public tokenEVRT;

    constructor(address _eEVRT, address _tokenEVRT) public {
        eEVRT = IERC20(_eEVRT);
        tokenEVRT = IERC20(_tokenEVRT);
    }
    
    // mapping of user address -> balance) 
    mapping(address => uint256) private _balances;
    uint256 private _totalSupply; 
  

    function deposit(address _token, uint256 _amount) external {
        // Check which cosumes less gas on avalanche, if or require
        require(_token == tokenEVRT, "Not everest token");
        require(_amount > 0, "Can't deposit 0")

        // Updates User balance
        _balances[msg.sender] = _balances[msg.sender].add(_amount);
        
        // Update total deposited in the pool
        _totalSupply = _totalSupply.add(_amount);

        tokenEVRT.safeTransferFrom(msg.sender, address(this), _amount);

        // TODO mint and give user corresponding eEVRT tokens
        
        // eEVRT.safeTransfer(msg.sender, _amount);

        emit Deposit(msg.sender, _amount);
    }


    function withdraw(address _eEVRT, uint256 _amount) external {
        
        // Check to see if user has enough funds, and amount > 0
        require(_balances[msg.sender] >= _amount && _amount > 0)
        
        // Updates User balance
        _balances[msg.sender] = _balances[msg.sender].sub(_amount);  
        _totalSupply = _totalSupply.sub(_amount);

        // TODO burn eEVRT token

        // TODO add rewards that user got in proportion to the money deposited in the pool
        uint256 totalAmount = _amount;
        // totalAmount.add(fees);

        tokenEVRT.safeTransfer(msg.sender, totalAmount);
        emit Withdraw(msg.sender, _amount);
    }

    // Todo function to calculate total rewards gained.
}

