// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "./Token.sol";
import "@openzeppelin/contracts/proxy/Clones.sol";

contract TokenFactory {
    address immutable tokenImplementation;
    address[] public tokens;
    
    constructor() {
        tokenImplementation = address(new HorseToken());
    }
    
    /**
     * 
     * @param name name of the horse 
     * @param symbol first 3 letters of name 
     * @param _price horse price in eth
     */
    function createToken(string calldata name, string calldata symbol, uint256 _price) external returns (address) {
        address clone = Clones.clone(tokenImplementation);
        HorseToken(clone).initialize(name, symbol, msg.sender, _price);
        tokens.push(clone);
        return clone;
    }
}