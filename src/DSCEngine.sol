//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {OracleLib, AggregatorV3Interface} from "./libraries/OracleLib.sol";
import {ReentrancyGuard} from "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {DecentralizedStableCoin} from "./DecentralizedStableCoin.sol";

contract DSCEngine is ReentrancyGuard {

    /////
    // Errors
    /////

    error DSCEngineTokenAddressAndPriceFeedAddressAmountDontMatch();
    error DSCEngineNeedsMoreThanZero();
    error DSCEngineTokenNotAllowed(address token);
    error DSCEngineTransferFailed();
    error DSCEngineBreaksHealthFactor(uint256 healthFactorValue);
    error DSCEngineMintFailed();
    error DSCEngineHealthFactorOk();
    error DSCEngineHealthFactorNotImproved();

    ///// Type Declarations /////
    using OracleLib for AggregatorV3Interface;

    ///// State Variables /////
    DecentralizedStableCoin private immutable i_dsc;
    uint256 private constant LIQUIDATION_THRESHOLD = 50;
    uint256 private constant LIQUIDATION_BONUS = 10;
    uint256 private constant LIQUIDATION_PRECISION = 100;
    uint256 private constant MIN_HEALTH_FACTOR = 1e18;
    uint256 private constant PRECISION = 1e18;
    uint256 private constant ADDITIONAL_FEED_PRECISION = 1e10;
    uint256 private constant FEED_PRECISION = 1e8;

    mapping(address collateralToken => address priceFeed) private s_priceFeeds;
    mapping(address user => mapping(address collateralToken => uint256 amount)) private s_collateralDeposited;
    mapping(address user => uint256 amount) private s_DSCMinted;
    address[] private s_collateralTokens;

    ///// Events /////
    event CollateralDeposited(address indexed user, address indexed token, uint256 indexed amount);
    event CollateralRedeemed(address indexed redeemFrom, address indexed reedemTo, address token, uint256 amount);

    ///// Modifiers /////
    modifier moreThanZero(uint256 amount) {
        if(amount == 0) {
            revert DSCEngineNeedsMoreThanZero();
        }
        _;
    }

    modifier isAllowedToken(address tokenAddress) {
        if(s_priceFeeds[tokenAddress] == address(0)){
            revert DSCEngineTokenNotAllowed(tokenAddress);
        }
        _;
    }

    ///// Functions /////

    constructor(address[] memory tokenAddress, address[] memory priceFeedAddresses, address dscAddress){
        if(tokenAddress.length != priceFeedAddresses.length){
            revert DSCEngineTokenAddressAndPriceFeedAddressAmountDontMatch();
        }

        //These feeds will be the USD pairs
        //for example, ETH/USD, or MKR/USD
        for(uint256 i = 0; i < tokenAddress.length; i++){
            s_priceFeeds[tokenAddress[i]] = priceFeedAddresses[i];
            s_collateralTokens.push(tokenAddress[i]);
        }

        i_dsc = DecentralizedStableCoin(dscAddress);
    }

    ///
    // External Functions
    ///

}
