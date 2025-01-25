// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

// Zaros dependencies
import { PremiumReport } from "src/external/chainlink/interfaces/IStreamsLookupCompatible.sol";
import { IVerifierProxy } from "src/external/chainlink/interfaces/IVerifierProxy.sol";
import { FeeAsset } from "src/external/chainlink/interfaces/IFeeManager.sol";
import { ChainlinkUtil } from "src/external/chainlink/ChainlinkUtil.sol";
import { Errors } from "src/utils/Errors.sol";

// PRB Math dependencies
import { UD60x18, ud60x18 } from "lib/prb-math/src/UD60x18.sol";

// Open Zeppelin dependencies
import { SafeCast } from "lib/openzeppelin-contracts/contracts/utils/math/SafeCast.sol";

library StabilityConfiguration {
    using SafeCast for int256;

    /// @notice ERC7201 storage location.
    bytes32 internal constant STABILITY_CONFIGURATION_LOCATION = keccak256(
        abi.encode(uint256(keccak256("fi.zaros.market-making.StabilityConfiguration")) - 1)
    ) & ~bytes32(uint256(0xff));

    /// @notice Structure holding data related to CL verification settings.
    /// @param chainlinkVerifier The proxy contract responsible for verifying data via Chainlink.
    /// @param maxVerificationDelay The maximum allowed delay (in seconds) for data verification.
    struct Data {
        IVerifierProxy chainlinkVerifier;
        uint256 maxVerificationDelay;
    }

    function load() internal pure returns (Data storage stabilityConfiguration) {
        bytes32 slot = keccak256(abi.encode(STABILITY_CONFIGURATION_LOCATION));
        assembly {
            stabilityConfiguration.slot := slot
        }
    }

    /// @notice Updates the settlement configuration.
    /// @param chainlinkVerifier The chainlink verifier addres
    /// @param maxVerificationDelay The max verfication delay for chainlink report
    function update(address chainlinkVerifier, uint128 maxVerificationDelay) internal {
        Data storage self = load();

        self.chainlinkVerifier = IVerifierProxy(chainlinkVerifier);
        self.maxVerificationDelay = maxVerificationDelay;
    }

    /// @notice Returns the offchain price.
    /// @dev New Stability strategies may be added in the future, hence the if-else statement.
    /// @param self The {StabilityConfiguration} storage pointer.
    /// @param priceData The unverified price report data.
    /// @return priceX18 The offchain price.
    function verifyOffchainPrice(Data storage self, bytes memory priceData) internal returns (UD60x18 priceX18) {
        bytes memory reportData = ChainlinkUtil.getReportData(priceData);

        IVerifierProxy chainlinkVerifier = self.chainlinkVerifier;
        (FeeAsset memory fee) = ChainlinkUtil.getEthVericationFee(chainlinkVerifier, reportData);
        bytes memory verifiedPricetData = ChainlinkUtil.verifyReport(chainlinkVerifier, fee, priceData);

        PremiumReport memory premiumReport = abi.decode(verifiedPricetData, (PremiumReport));

        if (block.timestamp > premiumReport.validFromTimestamp + self.maxVerificationDelay) {
            revert Errors.DataStreamReportExpired();
        }

        priceX18 = ud60x18(int256(premiumReport.price).toUint256());
    }
}
