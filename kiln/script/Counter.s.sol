// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
// import {Counter} from "../src/Counter.sol";
import {Escrow} from "../src/Escrow.sol";

// contract CounterScript is Script {
//     Counter public counter;
//
//     function setUp() public {}
//
//     function run() public {
//         vm.startBroadcast();
//
//         counter = new Counter();
//
//         vm.stopBroadcast();
//     }
// }

contract EscrowScript is Script {
	Escrow public escrow;

	function setUp() public {}

	function run() public {
		vm.startBroadcast();

		escrow = new Escrow();

		vm.stopBroadcast();
	}
}
