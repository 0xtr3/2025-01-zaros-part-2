// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

// Zaros dependencies
import { PriceAdapter } from "src/utils/PriceAdapter.sol";

// Open Zeppelin dependencies
import { ERC1967Proxy } from "lib/openzeppelin-contracts/contracts/proxy/ERC1967/ERC1967Proxy.sol";

// Forge dependencies
import { console } from "lib/forge-std/src/console.sol";

library PriceAdapterUtils {
    function deployPriceAdapter(PriceAdapter.InitializeParams memory params)
        internal
        returns (address priceAdapter)
    {
        address priceAdapterImplementation = address(new PriceAdapter());
        bytes memory InitializeParams = abi.encodeWithSelector(PriceAdapter.initialize.selector, params);
        priceAdapter = address(new ERC1967Proxy(priceAdapterImplementation, InitializeParams));

        console.log("%s - PriceAdapter deployed at: %s", params.name, priceAdapter);
    }
}
