// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "./TokenWithData.sol";
import "@openzeppelin/contracts/proxy/Clones.sol";

contract TokenFactoryWithData {
    address immutable tokenImplementation;
    address[] public tokens;
    constructor() {
        tokenImplementation = address(new HorseToken( address(bytes20(bytes("0xb83E47C2bC239B3bf370bc41e1459A34b41238D0"))), bytes32(bytes("0x66756e2d657468657265756d2d7365706f6c69612d3100000000000000000000"))));
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