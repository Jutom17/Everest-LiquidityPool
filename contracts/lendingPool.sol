// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./standards/ReentrancyGuard.sol";


// @notice Implements the actions of the LendingPool.
contract LendingPool is ReentrancyGuard {
  
    //@dev emitted on deposit  
    event Deposit(address indexed _reserve,
                  address indexed _user,
                  uint256 _amount,
                  uint16 indexed _referral,
                  uint256 _timestamp);

    //@dev emmited when a flashloan is executed
    event FlashLoan(address indexed _target,
                    address indexed _reserve,
                    uint256 _amount,
                    uint256 _totalFee,
                    uint256 _protocolFee,
                    uint256 _timestamp);

    // @dev functions affected by this modifier can only be invoked if the reserve
    // is active
    modifier onlyActiveReserve(address _reserve) {
        requireReserveActiveInternal(_reserve);
        _;
    }

    // @dev functions affected by this modifier can only be invoked if the provided
    // _amount input parameter is not zero.
    modifier onlyAmountGreaterThanZero(uint256 _amount) {
        requireAmountGreaterThanZeroInternal(_amount);
    }


    // @dev this function is invoked by the proxy contract when the LendingPool contract
    // is added to the AddressesProvider.
    function initialize() public initializer {
    
    }

    // @dev deposits the underlying asset into the reserve. A corresponding amount 
    // of the overlying asset (eTokens) is minted.
    function deposit() external payable nonReetrant [more here] {
    
    }

    
    // @ dev allows smartcontracts to access the liquidity of the pool within one transaction,
    // as long as the amount taken plus a fee is returned.
    function flashLoan() public nonReentrant onlyActiveReserve(_reserve) onlyAmountGreaterThanZero(_amount) {
        
        // Check that the reserve has enough available liquidity
        // we avoid using the getAvailableLiquidity() function in LendingPoolCore to save gas
        uint256 availableLiquidityBefore; // Not implemented

        require(availableLiquidityBefore >= _amount, 
                "There is not enough liquidity available to borrow");

        // Calculate fees 
    }



    // @notice internal funciton to save on code size for the onlyActiveReserve modifier
    function requireReserveActiveInternal(address _reserve) internal view {
        require(core.getReserveIsActive(_reserve), "Action requires an active reserve");
    }

    // @notice internal function to save on code size for the onlyAmountGreaterThanZero modifier
    function requireAmountGreaterThanZeroInternal(uint256 _amount) internal pure {
        require(_amount > 0, "Amount must be greater than 0");
    }


}
