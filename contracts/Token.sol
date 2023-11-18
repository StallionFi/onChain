// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import {ERC20Upgradeable} from "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";

contract HorseToken is ERC20Upgradeable {
    address owner;
    uint256 maxSupply;
    uint256 price;

    event ETHWithdrawn(uint256 amount);
    event TokenPurchase(uint256 amount, address buyer);

    function initialize(string calldata name, string calldata symbol, address _owner, uint256 _price) initializer public {
        __ERC20_init(name, symbol);
        owner = _owner;
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
        require(msg.sender == owner, "Not owner");
        (bool sent, bytes memory data) = msg.sender.call{value: amount}("");
        require(sent, "Failed to send Ether");
        emit ETHWithdrawn(amount);
    }
}