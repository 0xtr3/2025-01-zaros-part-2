// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

// Zaros dependencies
import { Referral } from "src/referral/Referral.sol";

// Open Zeppelin dependencies
import { ERC1967Proxy } from "lib/openzeppelin-contracts/contracts/proxy/ERC1967/ERC1967Proxy.sol";

// Forge dependencies
import { console } from "lib/forge-std/src/console.sol";

library ReferralUtils {
    function deployReferralModule(address owner) internal returns (address referralProxy) {
        address referralImplementation = address(new Referral());
        bytes memory initializeParams = abi.encodeWithSelector(Referral.initialize.selector, owner);
        referralProxy = address(new ERC1967Proxy(referralImplementation, initializeParams));

        console.log("Referral Module deployed at: %s", referralProxy);
    }
}
