const main = async () => {
  const rocketContractFactory = await hre.ethers.getContractFactory(
    "RocketPortal"
  );
  const rocketContract = await rocketContractFactory.deploy({
    value: hre.ethers.utils.parseEther("0.001"),
  });

  await rocketContract.deployed();

  console.log("RocketPortal address: ", rocketContract.address);
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
