// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Counter.sol";

interface HW0 {
    function solved2(address) external returns (bool);

    function merkleProof(bytes32[] memory proof) external;
}

contract CounterTest is Test {
    Counter public counter;
    uint256 mainnetFork;

    HW0 public hw0;

    function setUp() public {
        mainnetFork = vm.createFork(
            "FORK_URL"
        );
        vm.selectFork(mainnetFork);
        vm.rollFork(3888729);
        counter = new Counter();
        hw0 = HW0(0x5c561Afb29903D14B17B8C5EA934D6760C882b7d);
    }

    function testGenerateRoot() public {
        address user1 = makeAddr("user1");
        vm.startPrank(user1);
        bytes32[] memory proof = counter.generateRoot();
        hw0.merkleProof(proof);
        assertTrue(hw0.solved2(user1), "not solver");
    }
}
