pragma solidity ^0.8.19;

import "./Vault.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC4626.sol";

abstract contract VaultManager {
    struct Agreement {
        address payer;
        address payee;
        address arbiter;
        uint256 amount;
        uint256 creationTime;
        bool payerApproved;
        bool payeeApproved;
    }

    Agreement[] public agreements;
    Vault public vault;

    event AgreementCreated(uint256 indexed id, address payer, address payee, address arbiter, uint256 amount);
    event AgreementFunded(uint256 indexed id, uint256 depositedAmount);
    event AgreementReleased(uint256 indexed id, uint256 totalAssets);

    constructor(address _asset) {
        vault = new Vault(_asset);
    }

    function createAgreement(
        address _payer,
        address _payee,
        address _arbiter,
        uint256 _amount
    ) external returns (uint256) {
        require(_payer != _payee && _payer != _arbiter && _payee != _arbiter, "Addresses must be different");

        agreements.push(Agreement(_payer, _payee, _arbiter, _amount, block.timestamp, false, false));
        uint256 agreementId = agreements.length - 1;

        emit AgreementCreated(agreementId, _payer, _payee, _arbiter, _amount);
        return agreementId;
    }

    function fundAgreement(uint256 _id) external {
        require(_id < agreements.length, "Invalid agreement ID");
        Agreement storage ag = agreements[_id];
        require(msg.sender == ag.payer, "Only payer can fund");
        require(!ag.payerApproved, "Already funded");

        // Transférer les fonds du payer vers ce contrat
        require(vault.assetToken().transferFrom(msg.sender, address(this), ag.amount), "Transfer failed");

        // Déposer les fonds dans le Vault
        uint256 depositedShares = vault.deposit(ag.amount, address(this));
        ag.payerApproved = true;

        emit AgreementFunded(_id, depositedShares);
    }

    function releaseAgreement(uint256 _id) external {
        require(_id < agreements.length, "Invalid agreement ID");
        Agreement storage ag = agreements[_id];
        require(ag.payerApproved && ag.payeeApproved, "Agreement not fully approved");

        uint256 shares = vault.balanceOf(address(this));
        uint256 totalAssets = vault.redeem(shares, address(this), address(this));

        uint256 share = totalAssets / 3;
        uint256 remaining = totalAssets - 2 * share;

        require(vault.assetToken().transfer(ag.payer, share), "Transfer to payer failed");
        require(vault.assetToken().transfer(ag.payee, share), "Transfer to payee failed");
        require(vault.assetToken().transfer(ag.arbiter, remaining), "Transfer to arbiter failed");

        emit AgreementReleased(_id, totalAssets);
    }
}