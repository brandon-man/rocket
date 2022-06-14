const main = async () => {
  const rocketContractFactory = await hre.ethers.getContractFactory(
    "RocketPortal"
  );
  const rocketContract = await rocketContractFactory.deploy({
    value: hre.ethers.utils.parseEther("0.1"),
  });
  await rocketContract.deployed();
  console.log("Contract addy:", rocketContract.address);

  /*
   * Get Contract balance
   */
  let contractBalance = await hre.ethers.provider.getBalance(
    rocketContract.address
  );
  console.log(
    "Contract balance:",
    hre.ethers.utils.formatEther(contractBalance)
  );

  /**
   * Let's send a few rockets!
   */
  let rocketTxn = await rocketContract.rocket("This is rocket #1");
  await rocketTxn.wait(); // Wait for the transaction to be mined

  contractBalance = await hre.ethers.provider.getBalance(
    rocketContract.address
  );
  console.log(
    "Contract balance:",
    hre.ethers.utils.formatEther(contractBalance)
  );

  let allRockets = await rocketContract.getAllRockets();
  console.log(allRockets);
};

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
};

runMain();
