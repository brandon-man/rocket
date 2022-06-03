// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract RocketPortal {
    uint256 totalRockets;

 constructor() {
        console.log("Yo yo, I am a contract and I am smart");
    }

   function rocket() public {
        totalRockets += 1;
        console.log("%s sent a rocket!", msg.sender);
    }

  function getTotalRockets() public view returns (uint256) {
    console.log("We have %d total rockets!", totalRockets);
    return totalRockets;
  }
}
