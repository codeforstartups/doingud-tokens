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
import "@openzeppelin/contracts/utils/Strings.sol";

contract DGDTokenContract is ERC1155 {
    uint256 public constant AANG = 1;
    uint256 public constant ZUKO = 2;
    uint256 public constant KATARA = 3;
    uint256 public constant AZULA = 4;
    uint256 public constant BEIFONG = 5;
    uint256 public constant SOKKA = 6;
    uint256 public constant TYLEE = 7;
    uint256 public constant APPA = 8;
    uint256 public constant IROH = 9;
    uint256 public constant OZAI = 10;
    uint256 public constant SUKI = 11;
    uint256 public constant PRINCES = 12;


    constructor() public ERC1155("https://ipfs.io/ipfs/QmUV9LAbQnJwaoW2WUN9vAZo8riFWL26y33cNtmgNayAWC/{id}.json"){
        _mint(msg.sender  , AANG , 100 , "");
        _mint(msg.sender  , ZUKO , 100 , "");
        _mint(msg.sender  , KATARA , 100 , "");
        _mint(msg.sender  , AZULA , 100 , "");
        _mint(msg.sender  , BEIFONG , 100 , "");
        _mint(msg.sender  , SOKKA , 100 , "");
        _mint(msg.sender  , TYLEE , 100 , "");
        _mint(msg.sender  , APPA , 100 , "");
        _mint(msg.sender  , OZAI , 100 , "");
        _mint(msg.sender  , SUKI , 100 , "");
        _mint(msg.sender  , PRINCES , 100 , "");
    }

    
}
