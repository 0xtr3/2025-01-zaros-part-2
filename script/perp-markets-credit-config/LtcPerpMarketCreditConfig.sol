// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.25;

abstract contract LtcPerpMarketCreditConfig {
    /// @notice LTC perp market credit configuration parameters.
    // TODO: Update the engine address when the market will be deployed.
    address internal constant LTC_PERP_MARKET_CREDIT_CONFIG_ENGINE = address(0x9);
    address internal constant LTC_PERP_MARKET_CREDIT_CONFIG_ENGINE_USD_TOKEN = address(0x9);
    uint128 internal constant LTC_PERP_MARKET_CREDIT_CONFIG_ID = 9;
    uint128 internal constant LTC_PERP_MARKET_CREDIT_CONFIG_AUTO_DELEVERAGE_START_THRESHOLD = 0.5e18;
    uint128 internal constant LTC_PERP_MARKET_CREDIT_CONFIG_AUTO_DELEVERAGE_END_THRESHOLD = 0.6e18;
    uint128 internal constant LTC_PERP_MARKET_CREDIT_CONFIG_AUTO_DELEVERAGE_POWER_SCALE = 1e18;
    uint128 internal constant LTC_PERP_MARKET_CREDIT_CONFIG_MARKET_SHARE = 0.95e18;
    uint128 internal constant LTC_PERP_MARKET_CREDIT_CONFIG_FEE_RECIPIENTS_SHARE = 0.05e18;
}
