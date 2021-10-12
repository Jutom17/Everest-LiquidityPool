// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;


contract InterestRates {
    
    /**
    * @notice Calculates the current asset utilization rate using the following formula:
    *   `utilizationRate = totalBorrowed / totalDeposits` i.e. We have a pool with 
    *   100 AVAX and 80 of them  have been borrowed, that represents a utilization 
    *   rate of 80%.
    * @param _totalBorrowed - Total borrowed from the asset pool.
    * @param _totalDeposits - Total deposited in the asset pool.
    * @returns - Current utilization rate.
    **/
    function AssetUtilizationRate(
        uint256 _totalBorrowed, 
        uint256 _totalDeposits) public pure returns(uint256) {
        
        if (!_totalDeposits)
            return 0;

        uint256 utilizationRate;

        utilizationRate = _totalBorrowed / _totalDeposits;

        return utilizationRate;
    }
    
    /**
    * @notice Calculates the current borrowing rate using the following formula:
    *
    *
    * @param _totalBorrowed - Total borrowed from the asset pool.
    * @param _totalDeposits - Total deposited in the asset pool.
    * @returns - Current deposit rate.
    **/
    function calculateBorrowingRate(
        uint256 _totalBorrowed, 
        uint256 _totalDeposits) public pure returns(uint256) {
    
    }

    /**
    * @notice Calculates the current deposit rate using the following formula:
    *
    *
    * @param _totalBorrowed - Total borrowed from the asset pool.
    * @param _totalDeposits - Total deposited in the asset pool.
    * @returns - Current deposit rate.
    **/
    function calculateDepositRate(
        uint256 _totalBorrowed, 
        uint256 _totalDeposits) public pure returns(uint256) {
    
    }
    
}
