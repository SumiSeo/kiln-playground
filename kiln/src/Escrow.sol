// SPDX-Liscence-Identifier: MIT
pragma solidity ^0.8.0;

contract Escrow {

	// address arbiter = msg.sender; /* Arbiter address */

	struct Agreement {	/* Struct containing agreement details */
		address payer;
		address payee;
		address arbiter;
		uint amount;
		bool payerApproved;
		bool payeeApproved;
	}
	
	Agreement[] public agreements; /* Public dynamic Agreement data */

	/**
	  * Function to create an agreement/contract
	  *  
	  */
	function createAgreement(address _payer, address _payee, address _arbiter, uint _amount) external returns (uint){
		require (_payer != _payee && _payer != _arbiter && _payee != _arbiter);
		agreements.push(Agreement(_payer, _payee, _arbiter, _amount, false, false));

		return (agreements.length - 1);
	}

	/**
	  *	Corp make depositr on the vault 
	  */
	function deposit(uint _id) external payable {
		require (msg.sender == agreements[_id].payerApproved && msg.value == agreements[_id].amount);
		agreements[_id].payerApproved = true;
		// TRANSFER TO VAULT/ARBITER
	}

	/**
	  *	Freelancer accept agreement
	  */
	function acceptAgreement(uint _id) external {
		require (msg.sender == agreements[_id].payee);
		agreements[_id].payeeApproved = true;
	}

	/**
			*	Arbiter complete the agreement
	  */
	function complete(uint _id) external {
        require(msg.sender == agreements[_id].arbiter, "Only arbiter can complete");
        require(agreements[_id].payerApproved == true, "Payer has not paid");
        require(agreements[_id].payeeApproved == true, "Payee has not agreed");
        
		agreements[_id].payerApproved = false;
		agreements[_id].payeeApproved = false;
		payable(agreements[_id].payee).transfer(agreements[_id].amount);
    }


	/**
	  *	Freelancer withdraw
	  */ 
	// function withdraw(uint _id) external {
	// 	require (msg.sender == agreements[_id].payee && agreements[_id].payerApproved == true);
	// 	agreements[_id].payerApproved = false;
	// 	payable(agreements[_id].payee).transfer(agreements[_id].amount);
	// }
}

