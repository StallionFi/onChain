// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {ERC20Upgradeable} from "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import {FunctionsClient} from "@chainlink/contracts/src/v0.8/functions/dev/v1_0_0/FunctionsClient.sol";
import {ConfirmedOwner} from "@chainlink/contracts/src/v0.8/shared/access/ConfirmedOwner.sol";
import {FunctionsRequest} from "@chainlink/contracts/src/v0.8/functions/dev/v1_0_0/libraries/FunctionsRequest.sol";

contract HorseToken is ERC20Upgradeable, FunctionsClient, ConfirmedOwner{
    using FunctionsRequest for FunctionsRequest.Request;
    address horseOwner;
    uint256 maxSupply;
    uint256 price;

    bytes32 public donId;

    bytes32 public s_lastRequestId;
    bytes public s_lastResponse;
    bytes public s_lastError;

    event ETHWithdrawn(uint256 amount);
    event TokenPurchase(uint256 amount, address buyer);

    constructor(address router, bytes32 _donId) FunctionsClient(router) ConfirmedOwner(msg.sender) {
        donId = _donId;
    }

    function initialize(string calldata name, string calldata symbol, address _owner, uint256 _price) initializer public {
        __ERC20_init(name, symbol);
        horseOwner = _owner;
        maxSupply = 100e18;
        price = _price; // price in eth for 1 token (18 decimals)
    }

    function mintTokens() payable external{
        uint256 tokenAmount = (msg.value / price); // ~ 1e18 / ~ 1 = 1e18
        require(
            tokenAmount + totalSupply() <= maxSupply,
            "Reached the current supply limit, check the remaining amount!" 
        );
        emit TokenPurchase(tokenAmount, _msgSender());
    }

    /**
     * @param amount in wei
     */
    function withdrawEth(uint256 amount) external {
        require(msg.sender == horseOwner, "Not owner");
        (bool sent, bytes memory data) = msg.sender.call{value: amount}("");
        require(sent, "Failed to send Ether");
        emit ETHWithdrawn(amount);
    }

    function sendRequest(
    string calldata source,
    FunctionsRequest.Location secretsLocation,
    bytes calldata encryptedSecretsReference,
    string[] calldata args,
    bytes[] calldata bytesArgs,
    uint64 subscriptionId,
    uint32 callbackGasLimit
  ) external onlyOwner {
    FunctionsRequest.Request memory req;
    req.initializeRequest(FunctionsRequest.Location.Inline, FunctionsRequest.CodeLanguage.JavaScript, source);
    req.secretsLocation = secretsLocation;
    req.encryptedSecretsReference = encryptedSecretsReference;
    if (args.length > 0) {
      req.setArgs(args);
    }
    if (bytesArgs.length > 0) {
      req.setBytesArgs(bytesArgs);
    }
    s_lastRequestId = _sendRequest(req.encodeCBOR(), subscriptionId, callbackGasLimit, donId);
  }


    function fulfillRequest(bytes32 requestId, bytes memory response, bytes memory err) internal override {
        s_lastResponse = response;
        s_lastError = err;
    }
}