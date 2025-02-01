// SPDX-Liscence-Identifier: MIT
pragma solidity ^0.8.0;

contract Escrow {

	struct Agreement {	/* Struct containing agreement details */
		address payer;
		address payee;
		address arbiter;
		uint amount;
		bool payerApproved;
		bool payeeApproved;
	}
	
	Agreement[] public agreement; /* Public dynamic Agreement data */

	/**
	  * Function to create an agreement/contract
	  *  
	  */
	function createAgreement(address _payer, address _payee, address _arbiter, uint _amount) external returns (uint){
		require (_payer != _payee && _payer != _arbiter && _payee != _arbiter);
		agreement.push(Agreement(_payer, _payee, _arbiter, _amount, false, false));

		return (agreement.length - 1);
	}

	/**
	  *	Make Deposit on the vault
	  */
	function deposit(uint _id) external payable {
		if (msg.sender == agreement[id].payer && msg.value == agreement[_index].amount)
			agreement[_id].payerApproved = true;
		else if (msg.sender == agreement[id].payee && msg.value == agreement[_index].amount)
			agreement[_id].payeeApproved = true;
	}

	/**
	  *	Make withdraw
	  */
}
