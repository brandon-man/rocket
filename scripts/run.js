const main = async () => {
  const [owner, randomPerson] = await hre.ethers.getSigners();
  const rocketContractFactory = await hre.ethers.getContractFactory(
    "RocketPortal"
  ); // compile contract
  const rocketContract = await rocketContractFactory.deploy(); // create local Ethereum network and refreshes local server
  await rocketContract.deployed(); // wait until contract is deployed

  console.log("Contract deployed to:", rocketContract.address);
  console.log("Contract deployed to:", owner.address);

  let rocketCount;
  rocketCount = await rocketContract.getTotalRockets();

  let rocketTxn = await rocketContract.rocket();
  await rocketTxn.wait();

  rocketCount = await rocketContract.getTotalRockets();

  rocketTxn = await rocketContract.connect(randomPerson).rocket();
  await rocketTxn.wait();

  rocketCount = await rocketContract.getTotalRockets();
};

const runMain = async () => {
  try {
    await main();
    process.exit(0); // exit Node process without error
  } catch (error) {
    console.log(error);
    process.exit(1); // exit Node process while indicating 'Uncaught Fatal Exception' error
  }
  // Read more about Node exit ('process.exit(num)') status codes here: https://stackoverflow.com/a/47163396/7974948
};

runMain();
