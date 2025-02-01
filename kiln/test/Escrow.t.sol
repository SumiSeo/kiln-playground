// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Escrow} from "../src/Escrow.sol";

contract CounterTest is Test {
    Escrow public escrow;

    function setUp() public {
        escrow = new Escrow();
        // escrow.createAgreement(0x0,0x01,0x11, 1);
    }

    // function test_Increment() public {
    //     escrow.increment();
    //     assertEq(escrow.number(), 1);
    // }
    //
    // function testFuzz_SetNumber(uint256 x) public {
    //     escrow.setNumber(x);
    //     assertEq(escrow.number(), x);
    // }
}
