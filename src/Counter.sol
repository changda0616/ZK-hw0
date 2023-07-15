// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
import "murky/Merkle.sol";
import "forge-std/Test.sol";

contract Counter {
    uint256 public number;

    function _hashPair(bytes32 a, bytes32 b) public pure returns (bytes32) {
        return a < b ? _efficientHash(a, b) : _efficientHash(b, a);
    }

    function _efficientHash(
        bytes32 a,
        bytes32 b
    ) private pure returns (bytes32 value) {
        assembly {
            mstore(0x00, a)
            mstore(0x20, b)
            value := keccak256(0x00, 0x40)
        }
    }

    function hash(string memory _text) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(_text));
    }

    function generateRoot() public returns (bytes32[] memory) {
        bytes32[10] memory list = [
            hash("zkplayground"),
            hash("zkpapaya"),
            hash("zkpeach"),
            hash("zkpear"),
            hash("zkpersimmon"),
            hash("zkpineapple"),
            hash("zkpitaya"),
            hash("zkplum"),
            hash("zkpomegranate"),
            hash("zkpomelo")
        ];

        bytes32 pair1 = _hashPair(list[0], list[1]);
        bytes32 pair2 = _hashPair(list[2], list[3]);
        bytes32 pair3 = _hashPair(list[4], list[5]);
        bytes32 pair4 = _hashPair(list[6], list[7]);
        bytes32 pair5 = _hashPair(list[8], list[9]);

        bytes32 parentPair1 = _hashPair(pair1, pair2);
        bytes32 parentPair2 = _hashPair(pair3, pair4);

        // console.logBytes32(list[1]);
        // console.logBytes32(pair2);
        // console.logBytes32(parentPair2);
        // console.logBytes32(pair5);

        bytes32 grantParentPair = _hashPair(parentPair1, parentPair2);
        bytes32 root = _hashPair(grantParentPair, pair5);
        // console.log('root');
        // console.logBytes32(root);
        bytes32[] memory ans = new bytes32[](4);
        ans[0] = list[1];
        ans[1] = pair2;
        ans[2] = parentPair2;
        ans[3] = pair5;
        return ans;
    }
}
