// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

// Zaros dependencies
import { PerpMarket } from "src/perpetuals/leaves/PerpMarket.sol";
import { MarketConfiguration } from "src/perpetuals/leaves/MarketConfiguration.sol";

contract MarketConfigurationHarness {
    function exposed_update(uint128 marketId, MarketConfiguration.Data memory params) external {
        PerpMarket.Data storage perpMarket = PerpMarket.load(marketId);
        MarketConfiguration.Data storage self = perpMarket.configuration;

        MarketConfiguration.update(
            self,
            MarketConfiguration.Data({
                name: params.name,
                symbol: params.symbol,
                priceAdapter: params.priceAdapter,
                initialMarginRateX18: params.initialMarginRateX18,
                maintenanceMarginRateX18: params.maintenanceMarginRateX18,
                maxOpenInterest: params.maxOpenInterest,
                maxSkew: params.maxSkew,
                maxFundingVelocity: params.maxFundingVelocity,
                minTradeSizeX18: params.minTradeSizeX18,
                skewScale: params.skewScale,
                orderFees: params.orderFees
            })
        );
    }
}
