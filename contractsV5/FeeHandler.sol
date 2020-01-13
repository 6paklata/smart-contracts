pragma solidity 0.5.11;

import "./IKyberDAO.sol";
import "./IFeeHandler.sol";

contract FeeHandler is IFeeHandler {

    IKyberDAO public kyberDAOContract;

    // Todo: Add the correct startBlock and epoch duration values
    uint constant STARTBLOCK = 0;
    uint constant EPOCH = 10000;

    uint public brrAndEpochData;

    uint constant SEPARATOR_BITS = 64;
    uint constant MAX_BPS = 10000;
    uint public brrAndEpochData;
    uint public burnInBPS;
    uint public rebateInBPS;
    uint public rewardInBPS;
    uint public epoch;
    uint public expiryBlock;

    uint public totalRebates;
    mapping(uint => uint) public totalRebatesPerEpoch;
    mapping(uint => address) public totalRebatesPerReserve;
    uint public totalRewards;
    mapping(uint => uint) public totalRewardsPerEpoch;
    mapping(address => address) public reserveOwners;

        
    function encodeData(uint _burn, uint _reward, uint _epoch, uint _expiryBlock) public {
        // return leftShift(leftShift(leftShift(a, 2) + b, 2) + c, 2) + d;
        brrAndEpochData = (((((_burn << SEPARATOR_BITS) + _reward) << SEPARATOR_BITS) + _epoch) << SEPARATOR_BITS) + _expiryBlock;
    }
    
    function decodeData() public {
        expiryBlock = brrAndEpochData & (1 << SEPARATOR_BITS) - 1;
        epoch = (brrAndEpochData / (1 << SEPARATOR_BITS)) & (1 << SEPARATOR_BITS) - 1;
        rewardInBPS = (brrAndEpochData / (1 << SEPARATOR_BITS << SEPARATOR_BITS)) & (1 << SEPARATOR_BITS) - 1;
        burnInBPS = (brrAndEpochData / (1 << SEPARATOR_BITS << SEPARATOR_BITS << SEPARATOR_BITS)) & (1 << SEPARATOR_BITS) - 1;
        rebateInBPS = MAX_BPS - rewardInBPS - burnInBPS;
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
