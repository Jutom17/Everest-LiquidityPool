// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'FlashLoanReceiver.sol';
import './interfaces/ILendingPoolAddressesProvider.sol';
import './interfaces/ILendingPool.sol';


contract FlashLoan is FlashLoanReceiver, Withdrawable {
    
    // Address of the LendingPool
    constructor(address _addressProvider) FlashLoanReceiver(_addressProvider) public {}

    /**
     * @dev This function must be called only by the LENDING_POOL and takes care of repaying
     * active debt positions, migrating collateral and incurring new debt token debt.
     *
     * @param assets - The array of flash loaned assets used to repay debts.
     * @param amounts - The array of flash loaned asset amounts used to repay debts.
     * @param premiums - The array of premiums incurred as additional debts.
     * @param initiator - The address that initiated the flask loan, unused.
     * @param params - The byte array containing, in this case, the arrays of eTokens and eTokenAmounts.
     */
    function executeOperation(
        address[] calldata assets,
        uint256[] calldata amounts,
        uint256[] calldata premiums,
        address initiator,
        bytes calldata params ) external override returns (bool) {
        
        //
        // This contract now has the funds requested.
        // Your logic goes here.
        //

        // At the end of your logic above, this contract owes
        // the flashloaned amounts + premiums.
        // Therefore ensure your contract has enough to repay
        // these amounts.

        // Approve the LendingPool contract allowance to *pull* the owed amount
        for (uint i = 0; i <assets.length; i++) {
            uint amountOwing = amounts[i].add(premiums[i]);
            IERC20(assets[i]).approve(address(LENDING_POOL), amountOwing);
        }

        return true; 

    }

    function _flashloan(address[] memory assets, uint256[] memory amounts) internal {
        address receiverAddress = address(this);

        address onBehalfOf = address(this);
        bytes memory params = "";
        uint16 referralCode = 0;

        uint256[] memory modes = new uint256[](assets.length);

        // 0 = no debt (flash), 1=stable, 2=variable
        for (uint256 i = 0; i < assets.length; i++) {
            modes[i] = 0;
        }

        LENDING_POOL.flashloan(
            receiverAddress,
            assets,
            amounts,
            modes,
            onBehalfOf,
            params,
            referralCode
        );

    }

    // Flash multiple assets
    function flashloan(address[] memory assets, uint256[] memory amounts) public onlyOwner {
        _flashloan(assets, amounts);
    }

    // Flash loan 1 ether woth of '_asset'
    // @param _asset - any ERC20 asset
    function flashloan(address _asset) public onlyOwner {
        bytes memory data = "";
        // amount that will be borrowed
        uint amount = 1 ether;

        address[] memory assets = new address[](1);
        assets[0] = _asset;

        uint256[] memory amounts = new uint256[](1);
        amounts[0] = amount;

        _flashloan(assets, amounts);
    }
}

