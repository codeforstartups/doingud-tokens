//NFT-Gating
//SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/utils/Strings.sol";


/**
 * Get balance of visitor for an id, 
 * if visitor have access to t
 */

contract TokenGating is ERC1155{
    address visitor = 0x15977c6EA676299C697057b443eBff85cE0bF146;
    bool isAccessAllowed;

    function userAccessNFTGating(uint _tokenId) public view returns(bool) {
        
    }   
}