pragma solidity >=0.5.0 <0.6.0;

//This file should import from zombieattack.sol.
import "./zombieattack.sol";

//When implementing a token contract, the first thing we do is copy the interface 
//to its own Solidity file and import it, import "./erc721.sol";. 
//Then we have our contract inherit from it, and we override each method with a function definition.
// Import file here
import"./erc721.sol";

//Declare a new contract, ZombieOwnership, that inherits from ZombieAttack. Leave the body of the contract empty for now.
//Luckily in Solidity, your contract can inherit from multiple contracts 
// Declare ERC721 inheritance here
contract ZombieOwnership is ZombieAttack, ERC721 {
  function balanceOf(address _owner) external view returns (uint256) {
    // 1. Return the number of zombies `_owner` has here
    return ownerZombieCount[_owner];
  }

  function ownerOf(uint256 _tokenId) external view returns (address) {
    // 2. Return the owner of `_tokenId` here
    return zombieToOwner[_tokenId];
  }
  
  
  // Define _transfer() here
  function _transfer(address _from, address _to, uint256 _tokenId) private {
    // increment ownerZombieCount for the person receiving the zombie (address _to). Use ++ to increment.
    ownerZombieCount[_to]++;
    //decrease the ownerZombieCount for the person sending the zombie (address _from). Use -- to decrement.
    ownerZombieCount[_from]--;
    //change zombieToOwner mapping for this _tokenId so it now points to _to.
    zombieToOwner[_tokenId] =  _to;
    //The ERC721 spec includes a Transfer event. The last line of this function should fire Transfer with the correct information — check erc721.sol to see what arguments it's expecting to be called with and implement it here.
    emit Transfer (_from, _to, _tokenId);
  }

  function transferFrom(address _from, address _to, uint256 _tokenId) external payable {

  }

  function approve(address _approved, uint256 _tokenId) external payable {

  }

}
