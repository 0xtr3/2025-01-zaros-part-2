// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

// Zaros dependencies
import { UpgradeBranch } from "src/tree-proxy/branches/UpgradeBranch.sol";
import { LookupBranch } from "src/tree-proxy/branches/LookupBranch.sol";
import { PerpsEngineConfigurationBranch } from "src/perpetuals/branches/PerpsEngineConfigurationBranch.sol";
import { LiquidationBranch } from "src/perpetuals/branches/LiquidationBranch.sol";
import { OrderBranch } from "src/perpetuals/branches/OrderBranch.sol";
import { PerpMarketBranch } from "src/perpetuals/branches/PerpMarketBranch.sol";
import { SettlementBranch } from "src/perpetuals/branches/SettlementBranch.sol";
import { TradingAccountBranchTestnet } from "./branches/TradingAccountBranchTestnet.sol";

abstract contract IPerpsEngineTestnet is
    UpgradeBranch,
    LookupBranch,
    PerpsEngineConfigurationBranch,
    LiquidationBranch,
    OrderBranch,
    PerpMarketBranch,
    SettlementBranch,
    TradingAccountBranchTestnet
{ }
