// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/IERC4626.sol";

contract VaultManager {
    IERC20 public immutable asset;
    IERC4626 public immutable vault;

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

    event AgreementCreated(uint256 indexed id, address payer, address payee, address arbiter, uint256 amount);
    event AgreementFunded(uint256 indexed id, uint256 depositedAmount);
    event AgreementReleased(uint256 indexed id, uint256 totalAssets);

    constructor(address _asset, address _vault) {
        require(_asset != address(0) && _vault != address(0), "Invalid addresses");
        asset = IERC20(_asset);
        vault = IERC4626(_vault);
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
        require(asset.transferFrom(msg.sender, address(this), ag.amount), "Transfer failed");

        // Approuver le vault pour le dépôt
        asset.approve(address(vault), ag.amount);

        // Dépôt dans le vault pour générer des intérêts
        uint256 depositedShares = vault.deposit(ag.amount, address(this));
        require(depositedShares > 0, "Deposit failed");

        ag.payerApproved = true;

        emit AgreementFunded(_id, ag.amount);
    }

    function approveAgreement(uint256 _id) external {
        require(_id < agreements.length, "Invalid agreement ID");
        Agreement storage ag = agreements[_id];
        require(msg.sender == ag.payee, "Only payee can approve");
        require(ag.payerApproved, "Payer must deposit first");

        ag.payeeApproved = true;
    }

    function releaseFunds(uint256 _id) external {
        require(_id < agreements.length, "Invalid agreement ID");
        Agreement storage ag = agreements[_id];
        require(ag.payerApproved && ag.payeeApproved, "Agreement not fully approved");

        // Récupérer la valeur initiale et les intérêts accumulés
        uint256 shares = vault.balanceOf(address(this));
        require(shares > 0, "No shares available");

        uint256 totalAssets = vault.redeem(shares, address(this), address(this));
        require(totalAssets > 0, "Redeem failed");

        // Distribution des fonds
        uint256 share = totalAssets / 3;
        uint256 remaining = totalAssets - (2 * share); // Évite les erreurs d'arrondi

        require(asset.transfer(ag.payer, share), "Transfer to payer failed");
        require(asset.transfer(ag.payee, share), "Transfer to payee failed");
        require(asset.transfer(ag.arbiter, remaining), "Transfer to arbiter failed");

        emit AgreementReleased(_id, totalAssets);
    }
}
