const main = async () => {
  const rocketContractFactory = await hre.ethers.getContractFactory(
    "RocketPortal"
  );
  const rocketContract = await rocketContractFactory.deploy();
  await rocketContract.deployed();
  console.log("Contract addy:", rocketContract.address);

  let rocketCount;
  rocketCount = await rocketContract.getTotalRockets();
  console.log(rocketCount.toNumber());

  /**
   * Let's send a few rockets!
   */
  let rocketTxn = await rocketContract.rocket("A message!");
  await rocketTxn.wait(); // Wait for the transaction to be mined

  const [_, randomPerson] = await hre.ethers.getSigners();
  rocketTxn = await rocketContract
    .connect(randomPerson)
    .rocket("Another message!");
  await rocketTxn.wait(); // Wait for the transaction to be mined

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
