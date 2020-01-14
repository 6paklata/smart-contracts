pragma solidity 0.5.11;

import "./IKyberDAO.sol";
import "./IFeeHandler.sol";
import "./UtilsV5.sol";

contract FeeHandler is IFeeHandler, UtilsV5 {

    IKyberDAO public kyberDAOContract;

    // Todo: Add the correct startBlock and epoch duration values
    uint constant STARTBLOCK = 0;
    uint constant EPOCH = 10000;

    uint public brrAndEpochData;

    uint constant BITS_PER_PARAM = 64;
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
        brrAndEpochData = (((((_burn << BITS_PER_PARAM) + _reward) << BITS_PER_PARAM) + _epoch) << BITS_PER_PARAM) + _expiryBlock;
    }
    // todo: return 5 values from decode data, remove storage variables
    function decodeData() public {
        expiryBlock = brrAndEpochData & (1 << BITS_PER_PARAM) - 1;
        epoch = (brrAndEpochData / (1 << BITS_PER_PARAM)) & (1 << BITS_PER_PARAM) - 1;
        rewardInBPS = (brrAndEpochData / (1 << BITS_PER_PARAM << BITS_PER_PARAM)) & (1 << BITS_PER_PARAM) - 1;
        burnInBPS = (brrAndEpochData / (1 << BITS_PER_PARAM << BITS_PER_PARAM << BITS_PER_PARAM)) & (1 << BITS_PER_PARAM) - 1;
        rebateInBPS = BPS - rewardInBPS - burnInBPS;
    }

    function handleFees(address[] calldata eligibleReserves, uint[] calldata rebatePercentages) external payable returns(bool) {
        
        // Per trade check epoch number, and if changed, call DAO to get existing percentage values for reward / burn / rebate
        // Rebates to reserves if entitled. (if reserve isn’t entitled, it means fee wasn’t taken!)
        // Internal accounting per reserve.
        // Update total_reserve_rebate
        // Update rewards
        // Update total_reward [epoch]
        // Update total_reward_amount.
        // Eth for burning is the remaining == (total balance - total_reward_amount - total_reserve_rebate).


        // When you update reserve rebate, you must first check if 2 reserves i.e. handled on both token to eth n eth to token.
        // encode totals, 128 bits per reward / rebate.
        // accumulate rebates per wallet instead of per reserve use reserveOwners
        return true;
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

    function burnKNC() public {
        // only DAO?
        // convert fees to KNC and burn
    }

    // Don't work on this yet
    function setReserveAdmin(address reserve, address admin) public {
        // Add onlyAdmin modifier

    }

    function updateReserveOwner(address owner) public {
        // only Admin?
        // do we really need this? think anyone can just call claimRebate for reserve and it'll just send the rebates to the reserve address;
    }


}
