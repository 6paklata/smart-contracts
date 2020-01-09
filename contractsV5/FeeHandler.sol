pragma solidity 0.5.11;

import "./IKyberDAO.sol";
import "./IFeeHandler.sol";

contract FeeHandler is IFeeHandler {

    IKyberDAO public kyberDAOContract;

    // Todo: Add the correct startBlock and epoch duration values
    uint constant STARTBLOCK = 0;
    uint constant EPOCH = 10000;

    uint public brrData;

    uint public totalRebates;
    mapping(uint => uint) public totalRebatesPerEpoch;
    mapping(uint => address) public totalRebatesPerReserve;
    uint public totalRewards;
    mapping(uint => uint) public totalRewardsPerEpoch;
    mapping(address => address) public reserveOwners;

    function encodeBRRData() internal returns(uint) {
        return 1;
    }

    function decodeBRRData() internal returns(uint, uint) {
        return (1,2);
    }

    function handleFees(address[] calldata eligibleReserves, uint[] calldata rebatePercentages) external payable returns(bool) {
        return true;
    }

    function setReserveAdmin(address reserve, address admin) public {
        // Add onlyAdmin modifier

    }

    function claimStakerReward(address staker, uint percentageinPrecision, uint epoch) public {
        // onlyDAO
        // send reward
        // update rewardPerEpoch
        // update totalReward
    }

    function claimReserveRebate(address reserve) public {
        // only DAO
        // send rebate to reserve
        // update rebatePerReserve;
        // update total rebate amounts?
        // update reserve rebate to 1 (avoid 0...) otherwise div by 0 issue? but will we even need to div by 0?
        // if we include a dest address, we need an owner / admin of the reserve and the below function.
    }

    function updateReserveOwner(address owner) public {
        // only Admin?
        // do we really need this? think anyone can just call claimRebate for reserve and it'll just send the rebates to the reserve address;
    }

    function burnKNC() public {
        // only DAO?
        // convert fees to KNC and burn
    }
}
