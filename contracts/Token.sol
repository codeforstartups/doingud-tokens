//Contracts/Token.sol
//SPDX-License-Indentifier : MIT

pragma solidity ^0.8.0;

/**
 * https://github.com/ethereum/EIPs/blob/master/EIPS/eip-1155.md#erc-1155-metadata-uri-json-schema
 
 * ability for holders to burn (destroy) their tokens

 * a minter role that allows for token minting (creation)

 * a pauser role that allows to stop all token transfers

 * # Multi Token Standard
 * distinct balance for each token id
 * non-fungible tokens are implemented by simply minting a single one of them
 * single ERC1155 token contract can hold the entire system state, reducing deployment costs and complexity.
 
 * # Batch Operations
 * it is possible to operate over multiple tokens in a single transaction very efficiently.
 
 * # Security & Bugs
 * https://etherscan.io/token/0xa74476443119A942dE498590Fe1f2454d7D4aC0d?a=0xa74476443119A942dE498590Fe1f2454d7D4aC0d
 * so transfers to it are disabled to prevent tokens from being locked forever
 */
import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";

contract DGDTokenContract is ERC1155 {
    uint256 public constant A = 0;
    uint256 public constant B = 0;
    uint256 public constant C = 0;
}
