//Contracts/Token.sol
//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/**

 * OpenSea Testnet : https://testnets.opensea.io/assets/0xad4053fc41570e8fecb8fca9b3bc924eac83a880/12
 * Rinkby Contract : https://rinkeby.etherscan.io/tx/0x1323d7f5cab8580c18c59987fba81fc5d3583f94df15f01f1b45f84d312b466a

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
import "openzeppelin-solidity/contracts/ownership/Ownable.sol";
import 'multi-token-standard/contracts/tokens/ERC1155/ERC1155Metadata.sol';
import 'multi-token-standard/contracts/tokens/ERC1155/ERC1155MintBurn.sol';

contract OwnableDelegateProxy { }

contract ProxyRegistry {
  mapping(address => OwnableDelegateProxy) public proxies;
}

contract DGDTokenContract is ERC1155 , Ownable{
    uint256 public constant AANG = 1;
    uint256 public constant ZUKO = 2;
    uint256 public constant KATARA = 3;
    uint256 public constant AZULA = 4;
    uint256 public constant BEIFONG = 5;

    mapping( uint256 => string) private _uris;

    address owner = 0x15977c6EA676299C697057b443eBff85cE0bF146;
    address visitor = 0x63dA72e8D2C5847BEb823E758892855F3A604936;

    uint256[] initialSupplies = [100,100,100,100,100];
    uint256[] minted = [0,0,0,0,0];
    uint256[] prices = [0.01 ether , 0.02 ether ,  0.03 ether ,  0.04 ether ,  0.05 ether ];

    constructor(address owner_)
        public
        ERC1155(
            "https://ipfs.io/ipfs/QmUV9LAbQnJwaoW2WUN9vAZo8riFWL26y33cNtmgNayAWC/{id}.json"
        )
    {

        owner = owner_;
       
    }

    modifier onlyOwner() {
        require(owner == owner, "only owner can call this");
        _;
    }

    function mint(address account, uint256 id, uint256 amount) payable public onlyOwner{


        require(id <= initialSupplies.length, "Token does't exists");
 
        require(id > 0, "Hooo, this we don't offer!");

        uint256 index = id -1;

        require(minted[index] + amount <= initialSupplies[index] , "For this token we don't have supplies");

        require(msg.value >= amount * prices[index] , "The amount is less");

        _mint(account , id , amount , "");

        minted[index] += amount; // after the minting is successful we will increase the amount for the supplies | reentrancy attack

    }

    function createERC1155Tokens(uint256 initialSupply) external onlyOwner{
        mint(owner, AANG, initialSupply[0], "");
        mint(owner, ZUKO, initialSupply[1], "");
        mint(owner, KATARA, initialSupply[2], "");
        mint(owner, AZULA, initialSupply[3], "");
        mint(owner, BEIFONG, initialSupply[4], "");
    }

    function withdraw() public onlyOwner{
        require(address(this).balance > 0 , "Not enought balance in the contract");
        payable(owner()).transfer(address(this).balance);
    }

    function uri(uint256 _tokenId)
        public
        override
        view
        returns (string memory)
    {
        return string(
                abi.encodePacked(
                    "https://ipfs.io/ipfs/QmUV9LAbQnJwaoW2WUN9vAZo8riFWL26y33cNtmgNayAWC/",
                    Strings.toString(_tokenId),
                    ".json"
                )
            );
    }

    function setTokenUri(uint256 tokenId , string memory uri) public {
        require(bytes(_uris[tokenId]).length == 0, "Cannot set uri twice");
        _uris[tokenId] = uri;
    }

    /**
        Batch Transfer: Transfer multiple assets in a single call.
        Batch Balance: Get the balances of multiple assets in a single call.
        Batch Approval: Approve all tokens to an address.
        EIP-165 Support: Declare supported interfaces.
        Hooks: Receive tokens hook.
        NFT support: If supply is only 1, treat it as NFT.
        Safe Transfer Rules: Set of rules for secure transfer.
    */
    
    bool isAccessAllowed;

    function userAccessNFTGating(uint _tokenId) public view returns(bool) {

    }   

    
    function mintBatch(address to, uint256[] memory ids, uint256[] memory amounts , bytes memory data) public onlyOwner{
        _mintBatch(to , ids , amounts , data);
    }

    
}
