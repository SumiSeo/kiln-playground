// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract AgreementNFT is ERC721, Ownable {
    uint256 public nextTokenId;
    address public vaultManager;

    constructor() ERC721("AgreementNFT", "ANFT") Ownable(msg.sender) {}

    function mint(address to) external onlyOwner returns (uint256) {
        uint256 tokenId = nextTokenId;
        _mint(to, tokenId);
        nextTokenId++;
        return tokenId;
    }

    function setVaultManager(address _vaultManager) external onlyOwner {
        vaultManager = _vaultManager;
    }

    function transferFromVaultManager(address from, address to, uint256 tokenId) external {
        require(msg.sender == vaultManager, "Only vault manager can transfer");
        _transfer(from, to, tokenId);
    }
}