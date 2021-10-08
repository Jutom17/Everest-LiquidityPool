// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { SafeMath } from './standards/SafeMath.sol';
import { IERC20 } from './standards/IERC20.sol';
import { SafeERC20 } from './standards/SafeERC20.sol';
import { IFlashLoanReceiver } from './interfaces/IFlashLoanReceiver.sol';
import { ILendingPoolAddressesProvider } from './interfaces/ILendingPoolAddressesProvider.sol';
import { ILendingPool } from './interfaces/ILendingPool.sol';
import '../utils/Withdrawable.sol';


/**
    !!!
    Never keep funds permanently on your FlashLoanReceiverBase contract as they could be
    exposed to a 'griefing' attack, where the stored funds are used by an attacker.
    !!!
 */
abstract contract FlaskLoanReceiver is IFlashLoanReceiver {
    using SafeERC20 for IERC20;
    using SafeMath for uint256;

    ILendingPoolAddressesProvider public immutable override ADDRESSES_PROVIDER;
    ILendingPool public immutable override LENDING_POOL;

    constructor(address provider) public {
        ADDRESSES_PROVIDER = ILendignPoolAddressesProvider(provider);
        LENDING_POOL = ILendingPool(ILendingPoolAddressesProvider(provider).getLendingPool());
    }

    receive() payable external {}
}
