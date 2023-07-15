// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/Counter.sol";
interface HW0 {
    function solved2(address) external returns (bool);
    function merkleProof(bytes32[] memory proof) external;
}
contract CounterScript is Script {
    Counter public counter;
    uint256 mainnetFork;
    HW0 public hw0;

    function setUp() public {
        counter = new Counter();
        hw0 = HW0(0x5c561Afb29903D14B17B8C5EA934D6760C882b7d);
    }
    function run() public {
        vm.broadcast();
        bytes32[] memory proof = counter.generateRoot();
        hw0.merkleProof(proof);
        require(hw0.solved2(address(this)), "not solver");
    }
}
