//SPDS-License-Identifier: MIT

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

contract NFTsMessage {
    /** Struct for a post */
    struct Post {
        address user;
        string text;
    }
    /** Struct for a comment */
    struct Commet {
        address user;
        string text;
    }

    mapping (address => uint256[]) public postsFromAcc;
    mapping (uint256 => uint256[]) public commentsOnPosts;
    mapping (uint256 => address) public commentFromAccount;

    Post[] public posts;
    Comment[] public comments;

    // event to be emited when post get added 
    event NewPostAdded(uint postId, uint commentId, address owner);

    constructor () public {
        newPost("");
        newComment(0, "");
    }

    function hasPosts() public view returns(bool _hasPosts) {
        _hasPosts = posts.length > 0;
    }

    function newPost(string _text) public {
        Post memory post = Post(_text);
        uint postId = posts.push(post) - 1;
        postsFromAcc[msg.sender].push(postId);
        emit NewPostAdded(postId, 0, msg.sender);
    }

    function newComment(uint _postId, string _text) public {
        Comment memory comment = Comment(_text);
        uint commentId = comments.push(comment) - 1;
        commentsOnPosts[_postId].push(commentId);
        commentFromAccount[commentId] = msg.sender;
        emit NewPostAdded(_postId, commentId, msg.sender);
    }



}