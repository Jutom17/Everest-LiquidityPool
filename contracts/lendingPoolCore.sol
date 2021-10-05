// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./standards/Initializable.sol";
import "./libraries/CoreLibrary";

//@notice Holds the state of the lending pool and all the funds deposited
contract LendingPoolCore is Initializable {


    // @dev Emitted when the state of a reserve is updated
    event ReserveUpdated(address indexed reserve,
                         uint256 liquidityRate,
                         uint256 stableBorrowRate,
                         uint256 variableBorrowRate,
                         uint256 liquidityIndex,
                         uint256 variableBorrowIndex);

    address public lendingPoolAddress;
   
    // @ only lending pools can use functions affected by this modifier 
    modifier onlyLendingPool {
        require(lendingPoolAddress == msg.sender, "The caller must be a lending pool contract");
    }
    
    mapping(address => CoreLibrary.ReserveData) internal reserves;
    mapping(address => mapping(address => CoreLibrary.UserReserveData)) internal usersReserveData;
    
    address[] public reservesList;

    // @dev initialized the Core contract, invoked upon registration on the AddressesProvider
    function initialize(LendingPoolAddressesProvider _addressesProvider) public initializer {
        addressesProvider = _addressesProvider;
        refreshConfigInternal();
    }

    // @dev updates the state of the core as a result of a deposit action
    function updateStateDeposit(address _reserve,
                                address _user,
                                uint256 _amount,
                                bool _isFirstDeposit) external onlyLendingPool {
    
    }

    // @dev updates the state of the core as a result of a flashloan action
    function updateStateOnFlashLoan(address _reserve,
                                    uint256 _availableLiquidityBefore,
                                    uint256 _income,
                                    uint256 _protocolFee) external onlyLendingPool {
    
    }

    // @dev transfers to the protocol fees of a flashloan to the fee collection address
    function trasnferFlashLoanProtocolFeeInternal(address _token, uint256 _amount) internal {
    
    }

}
