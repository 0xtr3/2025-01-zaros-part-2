// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

// Zaros dependencies
import { Errors } from "src/utils/Errors.sol";
import { Base_Test } from "test/Base.t.sol";
import { PerpsEngineConfigurationBranch } from "src/perpetuals/branches/PerpsEngineConfigurationBranch.sol";

contract ConfigureSystemParameters_Integration_Test is Base_Test {
    function setUp() public override {
        Base_Test.setUp();
        changePrank({ msgSender: users.owner.account });
        configureSystemParameters();

        createPerpMarkets();

        changePrank({ msgSender: users.naruto.account });
    }

    function testFuzz_RevertWhen_MaxPositionsPerAccountIsZero(
        uint128 marketOrderMinLifetime,
        uint128 liquidationFeeUsdX18
    )
        external
    {
        // it should revert
        vm.expectRevert({ revertData: abi.encodeWithSelector(Errors.ZeroInput.selector, "maxPositionsPerAccount") });

        changePrank({ msgSender: users.owner.account });
        perpsEngine.configureSystemParameters(
            0,
            marketOrderMinLifetime,
            liquidationFeeUsdX18,
            feeRecipients.marginCollateralRecipient,
            feeRecipients.orderFeeRecipient,
            feeRecipients.settlementFeeRecipient,
            users.liquidationFeeRecipient.account,
            address(marketMakingEngine),
            address(referralModule),
            address(whitelist),
            MAX_VERIFICATION_DELAY,
            true
        );
    }

    modifier whenMaxPositionsPerAccountIsNotZero() {
        _;
    }

    function testFuzz_RevertWhen_LiquidationFeeIsZero(
        uint128 maxPositionsPerAccount,
        uint128 marketOrderMinLifetime
    )
        external
        whenMaxPositionsPerAccountIsNotZero
    {
        vm.assume(maxPositionsPerAccount > 0);
        vm.assume(marketOrderMinLifetime > 0);

        // it should revert
        vm.expectRevert({ revertData: abi.encodeWithSelector(Errors.ZeroInput.selector, "liquidationFeeUsdX18") });

        changePrank({ msgSender: users.owner.account });
        perpsEngine.configureSystemParameters(
            maxPositionsPerAccount,
            marketOrderMinLifetime,
            0,
            feeRecipients.marginCollateralRecipient,
            feeRecipients.orderFeeRecipient,
            feeRecipients.settlementFeeRecipient,
            users.liquidationFeeRecipient.account,
            address(marketMakingEngine),
            address(referralModule),
            address(whitelist),
            MAX_VERIFICATION_DELAY,
            true
        );
    }

    modifier whenLiquidationFeeIsNotZero() {
        _;
    }

    function testFuzz_RevertWhen_MarginCollateralRecipientIsZero(
        uint128 maxPositionsPerAccount,
        uint128 marketOrderMinLifetime,
        uint128 liquidationFeeUsdX18
    )
        external
        whenMaxPositionsPerAccountIsNotZero
        whenLiquidationFeeIsNotZero
    {
        vm.assume(maxPositionsPerAccount > 0);
        vm.assume(marketOrderMinLifetime > 0);
        vm.assume(liquidationFeeUsdX18 > 0);

        // it should revert
        vm.expectRevert({ revertData: abi.encodeWithSelector(Errors.ZeroInput.selector, "marginCollateralRecipient") });

        changePrank({ msgSender: users.owner.account });
        perpsEngine.configureSystemParameters(
            maxPositionsPerAccount,
            marketOrderMinLifetime,
            liquidationFeeUsdX18,
            address(0),
            feeRecipients.orderFeeRecipient,
            feeRecipients.settlementFeeRecipient,
            users.liquidationFeeRecipient.account,
            address(marketMakingEngine),
            address(referralModule),
            address(whitelist),
            MAX_VERIFICATION_DELAY,
            true
        );
    }

    modifier whenMarginCollateralRecipientIsNotZero() {
        _;
    }

    function testFuzz_RevertWhen_OrderFeeRecipientIsZero(
        uint128 maxPositionsPerAccount,
        uint128 marketOrderMinLifetime,
        uint128 liquidationFeeUsdX18
    )
        external
        whenMaxPositionsPerAccountIsNotZero
        whenLiquidationFeeIsNotZero
        whenMarginCollateralRecipientIsNotZero
    {
        vm.assume(maxPositionsPerAccount > 0);
        vm.assume(marketOrderMinLifetime > 0);
        vm.assume(liquidationFeeUsdX18 > 0);

        // it should revert
        vm.expectRevert({ revertData: abi.encodeWithSelector(Errors.ZeroInput.selector, "orderFeeRecipient") });

        changePrank({ msgSender: users.owner.account });
        perpsEngine.configureSystemParameters(
            maxPositionsPerAccount,
            marketOrderMinLifetime,
            liquidationFeeUsdX18,
            feeRecipients.marginCollateralRecipient,
            address(0),
            feeRecipients.settlementFeeRecipient,
            users.liquidationFeeRecipient.account,
            address(marketMakingEngine),
            address(referralModule),
            address(whitelist),
            MAX_VERIFICATION_DELAY,
            true
        );
    }

    modifier whenOrderFeeRecipientIsNotZero() {
        _;
    }

    function testFuzz_RevertWhen_SettlementFeeRecipientIsZero(
        uint128 maxPositionsPerAccount,
        uint128 marketOrderMinLifetime,
        uint128 liquidationFeeUsdX18
    )
        external
        whenMaxPositionsPerAccountIsNotZero
        whenLiquidationFeeIsNotZero
        whenMarginCollateralRecipientIsNotZero
        whenOrderFeeRecipientIsNotZero
    {
        vm.assume(maxPositionsPerAccount > 0);
        vm.assume(marketOrderMinLifetime > 0);
        vm.assume(liquidationFeeUsdX18 > 0);

        // it should revert
        vm.expectRevert({ revertData: abi.encodeWithSelector(Errors.ZeroInput.selector, "settlementFeeRecipient") });

        changePrank({ msgSender: users.owner.account });
        perpsEngine.configureSystemParameters(
            maxPositionsPerAccount,
            marketOrderMinLifetime,
            liquidationFeeUsdX18,
            feeRecipients.marginCollateralRecipient,
            feeRecipients.orderFeeRecipient,
            address(0),
            users.liquidationFeeRecipient.account,
            address(marketMakingEngine),
            address(referralModule),
            address(whitelist),
            MAX_VERIFICATION_DELAY,
            true
        );
    }

    modifier whenSettlementFeeRecipientIsNotZero() {
        _;
    }

    function testFuzz_RevertWhen_LiquidationFeeRecipientIsZero(
        uint128 maxPositionsPerAccount,
        uint128 marketOrderMinLifetime,
        uint128 liquidationFeeUsdX18
    )
        external
        whenMaxPositionsPerAccountIsNotZero
        whenLiquidationFeeIsNotZero
        whenMarginCollateralRecipientIsNotZero
        whenOrderFeeRecipientIsNotZero
        whenSettlementFeeRecipientIsNotZero
    {
        vm.assume(maxPositionsPerAccount > 0);
        vm.assume(marketOrderMinLifetime > 0);
        vm.assume(liquidationFeeUsdX18 > 0);

        // it should revert
        vm.expectRevert({ revertData: abi.encodeWithSelector(Errors.ZeroInput.selector, "liquidationFeeRecipient") });

        changePrank({ msgSender: users.owner.account });
        perpsEngine.configureSystemParameters(
            maxPositionsPerAccount,
            marketOrderMinLifetime,
            liquidationFeeUsdX18,
            feeRecipients.marginCollateralRecipient,
            feeRecipients.orderFeeRecipient,
            feeRecipients.settlementFeeRecipient,
            address(0),
            address(marketMakingEngine),
            address(referralModule),
            address(whitelist),
            MAX_VERIFICATION_DELAY,
            true
        );
    }

    modifier whenLiquidationFeeRecipientIsNotZero() {
        _;
    }

    function testFuzz_RevertWhen_ReferralModuleIsZero(
        uint128 maxPositionsPerAccount,
        uint128 marketOrderMinLifetime,
        uint128 liquidationFeeUsdX18
    )
        external
        whenMaxPositionsPerAccountIsNotZero
        whenLiquidationFeeIsNotZero
        whenMarginCollateralRecipientIsNotZero
        whenOrderFeeRecipientIsNotZero
        whenSettlementFeeRecipientIsNotZero
        whenLiquidationFeeRecipientIsNotZero
    {
        vm.assume(maxPositionsPerAccount > 0);
        vm.assume(marketOrderMinLifetime > 0);
        vm.assume(liquidationFeeUsdX18 > 0);

        // it should revert
        vm.expectRevert({ revertData: abi.encodeWithSelector(Errors.ZeroInput.selector, "referralModule") });

        changePrank({ msgSender: users.owner.account });
        perpsEngine.configureSystemParameters(
            maxPositionsPerAccount,
            marketOrderMinLifetime,
            liquidationFeeUsdX18,
            feeRecipients.marginCollateralRecipient,
            feeRecipients.orderFeeRecipient,
            feeRecipients.settlementFeeRecipient,
            users.liquidationFeeRecipient.account,
            address(marketMakingEngine),
            address(0),
            address(whitelist),
            MAX_VERIFICATION_DELAY,
            true
        );
    }

    modifier whenReferralModuleIsNotZero() {
        _;
    }

    function testFuzz_RevertWhen_MaxVerificationDelayIsZero(
        uint128 maxPositionsPerAccount,
        uint128 marketOrderMinLifetime,
        uint128 liquidationFeeUsdX18
    )
        external
        whenMaxPositionsPerAccountIsNotZero
        whenLiquidationFeeIsNotZero
        whenMarginCollateralRecipientIsNotZero
        whenOrderFeeRecipientIsNotZero
        whenSettlementFeeRecipientIsNotZero
        whenLiquidationFeeRecipientIsNotZero
        whenReferralModuleIsNotZero
    {
        vm.assume(maxPositionsPerAccount > 0);
        vm.assume(marketOrderMinLifetime > 0);
        vm.assume(liquidationFeeUsdX18 > 0);

        // it should revert
        vm.expectRevert({ revertData: abi.encodeWithSelector(Errors.ZeroInput.selector, "maxVerificationDelay") });

        changePrank({ msgSender: users.owner.account });
        perpsEngine.configureSystemParameters(
            maxPositionsPerAccount,
            marketOrderMinLifetime,
            liquidationFeeUsdX18,
            feeRecipients.marginCollateralRecipient,
            feeRecipients.orderFeeRecipient,
            feeRecipients.settlementFeeRecipient,
            users.liquidationFeeRecipient.account,
            address(marketMakingEngine),
            address(referralModule),
            address(whitelist),
            0,
            true
        );
    }

    function test_WhenMaxVerificationdelayIsNotZero(
        uint128 maxPositionsPerAccount,
        uint128 marketOrderMinLifetime,
        uint128 liquidationFeeUsdX18
    )
        external
        whenMaxPositionsPerAccountIsNotZero
        whenLiquidationFeeIsNotZero
        whenMarginCollateralRecipientIsNotZero
        whenOrderFeeRecipientIsNotZero
        whenSettlementFeeRecipientIsNotZero
        whenLiquidationFeeRecipientIsNotZero
        whenReferralModuleIsNotZero
    {
        vm.assume(maxPositionsPerAccount > 0);
        vm.assume(marketOrderMinLifetime > 0);
        vm.assume(liquidationFeeUsdX18 > 0);

        // it should emit {LogConfigureSystemParameters} event
        vm.expectEmit({ emitter: address(perpsEngine) });
        emit PerpsEngineConfigurationBranch.LogConfigureSystemParameters(
            users.owner.account, maxPositionsPerAccount, marketOrderMinLifetime, liquidationFeeUsdX18
        );

        changePrank({ msgSender: users.owner.account });
        perpsEngine.configureSystemParameters(
            maxPositionsPerAccount,
            marketOrderMinLifetime,
            liquidationFeeUsdX18,
            feeRecipients.marginCollateralRecipient,
            feeRecipients.orderFeeRecipient,
            feeRecipients.settlementFeeRecipient,
            users.liquidationFeeRecipient.account,
            address(marketMakingEngine),
            address(referralModule),
            address(whitelist),
            MAX_VERIFICATION_DELAY,
            true
        );
    }
}
