// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import { RootProxy } from "src/tree-proxy/RootProxy.sol";
import { UpgradeBranch } from "src/tree-proxy/branches/UpgradeBranch.sol";
import { LookupBranch } from "src/tree-proxy/branches/LookupBranch.sol";
import { CreditDelegationBranch } from "src/market-making/branches/CreditDelegationBranch.sol";
import { FeeDistributionBranch } from "src/market-making/branches/FeeDistributionBranch.sol";
import { MarketMakingEngineConfigurationBranch } from
    "src/market-making/branches/MarketMakingEngineConfigurationBranch.sol";
import { StabilityBranch } from "src/market-making/branches/StabilityBranch.sol";
import { VaultRouterBranch } from "src/market-making/branches/VaultRouterBranch.sol";

// solhint-disable-next-line no-empty-blocks
abstract contract IMarketMakingEngine is
    UpgradeBranch,
    LookupBranch,
    CreditDelegationBranch,
    FeeDistributionBranch,
    MarketMakingEngineConfigurationBranch,
    StabilityBranch,
    VaultRouterBranch
{ }

contract MarketMakingEngine is RootProxy {
    constructor(InitParams memory initParams) RootProxy(initParams) { }
}
