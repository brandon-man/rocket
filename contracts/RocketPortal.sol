// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract RocketPortal {
    uint256 totalRockets;
    uint256 private seed;

    event NewRocket(address indexed from, uint256 timestamp, string message);
   
    struct Rocket {
        address rocketer; // The address of the user who waved.
        string message; // The message the user sent.
        uint256 timestamp; // The timestamp when the user sent a rocket.
    }
    /*
     * I declare a variable rockets that lets me store an array of structs.
     * This is what lets me hold all the rockets anyone ever sends to me!
     */
    Rocket[] rockets;
    /*
     * This is an address => uint mapping, meaning I can associate an address with a number!
     * In this case, I'll be storing the address with the last time the user sent a rocket at us.
     */
    mapping(address => uint256) public lastRocketSent;

 constructor() payable {
        console.log("We have been constructed!");
        /*
         * Set the initial seed
         */
        seed = (block.timestamp + block.difficulty) % 100;
    }
   /*
     * You'll notice I changed the rocket function a little here as well and
     * now it requires a string called _message. This is the message our user
     * sends us from the frontend!
     */
   function rocket(string memory _message) public {
        /*
         * We need to make sure the current timestamp is at least 15-minutes bigger than the last timestamp we stored
         */
        require(
          lastRocketSent[msg.sender] + 30 seconds < block.timestamp, 
          "You just sent a rocket! Please wait 30 seconds before sending an another."
        );
        /*
         * Update the current timestamp we have for the user
         */
        lastRocketSent[msg.sender] = block.timestamp;

        totalRockets += 1;
        console.log("%s sent a rocket!", msg.sender, _message);

        rockets.push(Rocket(msg.sender, _message, block.timestamp));
        /*
         * Generate a new seed for the next user that sends a wave
         */
        seed = (block.difficulty + block.timestamp + seed) % 100;

        console.log("Random # generated: %d", seed);
        /*
         * Give a 50% chance that the user wins the prize.
         */
        if (seed <= 20) {
          console.log("%s won!", msg.sender);

          uint256 prizeAmount = 0.0001 ether;
          require(
            prizeAmount <= address(this).balance, // balance of contract
            "Trying to withdraw more money than the contract has."
          );
          (bool success, ) = (msg.sender).call{value: prizeAmount}("");
          require(success, "Failed to withdraw money from contract.");
        }

        emit NewRocket(msg.sender, block.timestamp, _message);
    }
   /*
     * I added a function getAllRockets which will return the struct array, rockets, to us.
     * This will make it easy to retrieve the rockets from our website!
     */
    function getAllRockets() public view returns (Rocket[] memory) {
        return rockets;
    }

  function getTotalRockets() public view returns (uint256) {
    console.log("We have %d total rockets!", totalRockets);
    return totalRockets;
  }
}
