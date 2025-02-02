// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "./AgreementNFT.sol";
import "./Vault.sol";

contract VaultManager {
    AgreementNFT public agreementNFT;
    Vault public vault;

    struct Agreement {
        address payer;
        address payee;
        address arbiter;
        uint256 amount;
        uint256 timestamp;
        bool payerApproved;
        bool payeeApproved;
        uint256 nftId;
    }

    Agreement[] public agreements;

    event AgreementCreated(uint256 indexed id, address payer, address payee, address arbiter, uint256 amount);
    event AgreementFunded(uint256 indexed id, uint256 depositedShares);
    event AgreementReleased(uint256 indexed id, uint256 totalAssets);

    constructor(address _asset, address _agreementNFT) {
        vault = new Vault(_asset);
        agreementNFT = AgreementNFT(_agreementNFT);
    }

    function createAgreement(
        address _payer,
        address _payee,
        address _arbiter,
        uint256 _amount
    ) external returns (uint256) {
        require(_payer != _payee && _payer != _arbiter && _payee != _arbiter, "Addresses must be different");

        uint256 nftId = agreementNFT.mint(_payer);
        agreements.push(Agreement(_payer, _payee, _arbiter, _amount, block.timestamp, false, false, nftId));
        uint256 agreementId = agreements.length - 1;

        emit AgreementCreated(agreementId, _payer, _payee, _arbiter, _amount);
        return agreementId;
    }

    function fundAgreement(uint256 _id) external {
        require(_id < agreements.length, "Invalid agreement ID");
        Agreement storage ag = agreements[_id];
        require(msg.sender == ag.payer, "Only payer can fund");
        require(!ag.payerApproved, "Already funded");

        require(vault.assetToken().transferFrom(msg.sender, address(this), ag.amount), "Transfer failed");

        uint256 depositedShares = vault.deposit(ag.amount, address(this));
        ag.payerApproved = true;

        emit AgreementFunded(_id, depositedShares);
    }

   function releaseAgreement(uint256 _id) external {
    require(_id < agreements.length, "Invalid agreement ID");
    Agreement storage ag = agreements[_id];
    require(ag.payerApproved && ag.payeeApproved, "Agreement not fully approved");

    uint256 shares = vault.balanceOf(address(this));
    uint256 totalAssets = vault.convertToAssets(shares);
    uint256 remainingAssets = totalAssets - ag.amount;
    uint256 eigthypercent = (remainingAssets * 80) / 100;
    uint256 payerShare = eigthypercent / 2;
    uint256 arbiterShare = eigthypercent - payerShare;

    // Transférer les parts
    require(vault.assetToken().transfer(ag.payer, payerShare), "Transfer to payer failed");
    require(vault.assetToken().transfer(ag.arbiter, arbiterShare), "Transfer to arbiter failed");

    // Transférer le NFT du payer au payee
    agreementNFT.transferFromVaultManager(ag.payer, ag.payee, ag.nftId);

    emit AgreementReleased(_id, totalAssets);
    }
}