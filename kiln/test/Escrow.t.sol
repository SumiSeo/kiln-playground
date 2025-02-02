// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Escrow} from "../src/Escrow.sol";

contract CounterTest is Test {
    Escrow public escrow;

    function setUp() public {
        escrow = new Escrow();
        escrow.createAgreement(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266, 0x70997970C51812dc3A010C7d01b50e0d17dc79C8, 0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC, 9);
    }

    // function test_Deposit() public {
    //     escrow.deposit(0);
    //     assertEq(escrow.agreements.length, 1);
    // }

    // function testFuzz_SetNumber(uint256 x) public {
    //     escrow.setNumber(x);
    //     assertEq(escrow.number(), x);
    // }
}
