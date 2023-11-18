// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "./Token.sol";
import "@openzeppelin/contracts/proxy/Clones.sol";

contract TokenFactory {
    address immutable tokenImplementation;

    constructor() {
        tokenImplementation = address(new HorseToken());
    }

    function createToken(string calldata name, string calldata symbol, uint256 _price) external returns (address) {
        address clone = Clones.clone(tokenImplementation);
        HorseToken(clone).initialize(name, symbol, msg.sender, _price);
        return clone;
    }
}