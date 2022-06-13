// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract RocketPortal {
    uint256 totalRockets;

    event NewRocket(address indexed from, uint256 timestamp, string message);
    // A struct is basically a custom datatype where we can customize what we want to hold inside it.
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

 constructor() {
        console.log("I AM SMART CONTRACT. POG.");
    }
   /*
     * You'll notice I changed the rocket function a little here as well and
     * now it requires a string called _message. This is the message our user
     * sends us from the frontend!
     */
   function rocket(string memory _message) public {
        totalRockets += 1;
        console.log("%s sent a rocket!", msg.sender, _message);

          /*
         * This is where I actually store the rocket data in the array.
         */
        rockets.push(Rocket(msg.sender, _message, block.timestamp));

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
