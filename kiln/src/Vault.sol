pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/interfaces/IERC4626.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol";

contract Vault is IERC4626 {
    IERC20 public assetToken;
    uint256 public totalShares;
    uint256 public totalManagedAssets;

    mapping(address => uint256) public shares;

    constructor(address _asset) {
        assetToken = IERC20(_asset);
    }

    function deposit(uint256 assets, address receiver) external override returns (uint256) {
        require(assets > 0, "Assets must be greater than 0");
        require(receiver != address(0), "Receiver address cannot be zero");

        // Transfer assets to the vault
        require(assetToken.transferFrom(msg.sender, address(this), assets), "Transfer failed");

        // Mint shares to the receiver
        uint256 sharesToMint = convertToShares(assets);
        shares[receiver] += sharesToMint;
        totalShares += sharesToMint;
        totalManagedAssets += assets;

        return sharesToMint;
    }

    function mint(uint256 shareAmount, address receiver) external override returns (uint256) {
        require(shareAmount > 0, "Shares must be greater than 0");
        require(receiver != address(0), "Receiver address cannot be zero");

        // Calculate the equivalent amount of assets needed to mint the shares
        uint256 assets = convertToAssets(shareAmount);

        // Transfer assets to the vault
        require(assetToken.transferFrom(msg.sender, address(this), assets), "Transfer failed");

        // Mint shares to the receiver
        shares[receiver] += shareAmount;
        totalShares += shareAmount;
        totalManagedAssets += assets;

        return assets;
    }

    function withdraw(uint256 assets, address receiver, address owner) external override returns (uint256) {
        require(assets > 0, "Assets must be greater than 0");
        require(receiver != address(0), "Receiver address cannot be zero");
        require(owner != address(0), "Owner address cannot be zero");

        uint256 sharesToBurn = convertToShares(assets);
        require(shares[owner] >= sharesToBurn, "Insufficient shares");

        // Burn shares from the owner
        shares[owner] -= sharesToBurn;
        totalShares -= sharesToBurn;
        totalManagedAssets -= assets;

        // Transfer assets to the receiver
        require(assetToken.transfer(receiver, assets), "Transfer failed");

        return sharesToBurn;
    }

    function redeem(uint256 shareAmount, address receiver, address owner) external override returns (uint256) {
        require(shareAmount > 0, "Shares must be greater than 0");
        require(receiver != address(0), "Receiver address cannot be zero");
        require(owner != address(0), "Owner address cannot be zero");

        uint256 assets = convertToAssets(shareAmount);
        require(totalManagedAssets >= assets, "Insufficient assets");

        // Burn shares from the owner
        shares[owner] -= shareAmount;
        totalShares -= shareAmount;
        totalManagedAssets -= assets;

        // Transfer assets to the receiver
        require(assetToken.transfer(receiver, assets), "Transfer failed");

        return assets;
    }

    function totalAssets() external view override returns (uint256) {
        return totalManagedAssets;
    }

    function convertToShares(uint256 assets) public view override returns (uint256) {
        if (totalManagedAssets == 0) {
            return assets;
        }
        return (assets * totalShares) / totalManagedAssets;
    }

    function convertToAssets(uint256 shareAmount) public view override returns (uint256) {
        if (totalShares == 0) {
            return shareAmount;
        }
        return (shareAmount * totalManagedAssets) / totalShares;
    }

    function maxDeposit(address /*receiver*/) external pure override returns (uint256) {
        return type(uint256).max;
    }

    function maxMint(address /*receiver*/) external pure override returns (uint256) {
        return type(uint256).max;
    }

    function maxWithdraw(address owner) external view override returns (uint256) {
        return shares[owner];
    }

    function maxRedeem(address owner) external view override returns (uint256) {
        return shares[owner];
    }

    function previewDeposit(uint256 assets) external view override returns (uint256) {
        return convertToShares(assets);
    }

    function previewMint(uint256 shareAmount) external view override returns (uint256) {
        return convertToAssets(shareAmount);
    }

    function previewWithdraw(uint256 assets) external view override returns (uint256) {
        return convertToShares(assets);
    }

    function previewRedeem(uint256 shareAmount) external view override returns (uint256) {
        return convertToAssets(shareAmount);
    }

    function asset() external view override returns (address) {
        return address(assetToken);
    }

    function decimals() external view override returns (uint8) {
        return IERC20Metadata(address(assetToken)).decimals();
    }

    // Implémentation des fonctions manquantes de IERC20
    function allowance(address owner, address spender) external view override returns (uint256) {
        return assetToken.allowance(owner, spender);
    }

    function approve(address spender, uint256 value) external override returns (bool) {
        return assetToken.approve(spender, value);
    }

    function balanceOf(address account) external view override returns (uint256) {
        return assetToken.balanceOf(account);
    }

    function name() external view override returns (string memory) {
        return IERC20Metadata(address(assetToken)).name();
    }

    function symbol() external view override returns (string memory) {
        return IERC20Metadata(address(assetToken)).symbol();
    }

    function totalSupply() external view override returns (uint256) {
        return assetToken.totalSupply();
    }

    function transfer(address to, uint256 value) external override returns (bool) {
        return assetToken.transfer(to, value);
    }

    function transferFrom(address from, address to, uint256 value) external override returns (bool) {
        return assetToken.transferFrom(from, to, value);
    }
}