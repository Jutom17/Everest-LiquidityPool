// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./standards/IERC20.sol";
import "./interfaces/IFlashLoanReceiver.sol";
import "./interfaces/ILendingPoolAddressesProvider.sol";


contract FlashLoanReceiver is IFlashLoanReceiver {

    ILendingPoolAddressesProvider public addressesProvider;
    
    constructor(ILendingPoolAddressesProvider _provider) {
        addressesProvider = _provider; 
    }

    function transferFundsBackToPoolInternal(address _reserve, uint256 _amount) internal {
        address payable core = addressesProvider.getLendingPoolCore();

        transferInternal(core, _reserve, _amount);
    }

    function transferInternal(address payable _destination, address _reserve, uint256 _amount) internal {
        IERC20(_reserve).transfer(_destination, _amount); 
    }

    function getBalanceInternal(address _target, address _reserve) internal view returns(uint256) {
        return IERC20(_reserve).balanceOf(_target); 
    }
}
