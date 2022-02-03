//Contracts/Token.sol
//SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

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

    address owner = 0x15977c6EA676299C697057b443eBff85cE0bF146;
    address visitor = 0x63dA72e8D2C5847BEb823E758892855F3A604936;

    uint256[] initialSupplies = [100,100,100,100,100];
    uint256[] minted = [0,0,0,0,0];
    
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

    function mint(address account, uint256 id, uint256 amount, byte memory data) public onlyOwner{


        require(id <= initialSupplies.length, "Token does't exists");

        require(id != 0, "Hooo, this we don't offer!");

        uint256 index = id -1;

        require(minted[index] + amount <= initialSupplies[index] , "For this token we don't have supplies");

        _mint(account , id , amount , data);

        minted[index] += amount; // after the minting is successful we will increase the amount for the supplies | reentrancy attack

    }

    function mintBatch(address to, uint256[] memory ids, uint256[] memory amounts , bytes memory data) public onlyOwner{
        _mintBatch(to , ids , amounts , data);
    }

    function createERC1155Tokens(uint256 initialSupply) external onlyOwner{
        mint(owner, AANG, initialSupply, "");
        mint(owner, ZUKO, initialSupply, "");
        mint(owner, KATARA, initialSupply, "");
        mint(owner, AZULA, initialSupply, "");
        mint(owner, BEIFONG, initialSupply, "");
    }

    function uri(uint256 _tokenId)
        public
        override
        view
        returns (string memory)
    {
        return
            string(
                abi.encodePacked(
                    "https://ipfs.io/ipfs/QmUV9LAbQnJwaoW2WUN9vAZo8riFWL26y33cNtmgNayAWC/",
                    Strings.toString(_tokenId),
                    ".json"
                )
            );
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

    
}
