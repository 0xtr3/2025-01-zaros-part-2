// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

// Zaros dependencies
import { RootProxy } from "../RootProxy.sol";
import { RootUpgrade } from "../leaves/RootUpgrade.sol";

// Open Zeppelin Upgradeable dependencies
import { Initializable } from "lib/openzeppelin-contracts-upgradeable/contracts/proxy/utils/Initializable.sol";
import { OwnableUpgradeable } from "lib/openzeppelin-contracts-upgradeable/contracts/access/OwnableUpgradeable.sol";

contract UpgradeBranch is Initializable, OwnableUpgradeable {
    using RootUpgrade for RootUpgrade.Data;

    constructor() {
        _disableInitializers();
    }

    function initialize(address owner) external initializer {
        __Ownable_init(owner);
    }

    function upgrade(
        RootProxy.BranchUpgrade[] memory branchUpgrades,
        address[] memory initializables,
        bytes[] memory initializePayloads
    )
        external
    {
        _authorizeUpgrade(branchUpgrades);
        RootUpgrade.Data storage rootUpgrade = RootUpgrade.load();

        rootUpgrade.upgrade(branchUpgrades, initializables, initializePayloads);
    }

    function _authorizeUpgrade(RootProxy.BranchUpgrade[] memory) internal onlyOwner { }
}
