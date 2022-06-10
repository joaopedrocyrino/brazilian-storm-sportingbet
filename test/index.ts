const { poseidonContract } = require("circomlibjs");
const { expect } = require("chai");
const { ethers } = require("hardhat");
const { groth16 } = require("snarkjs");

// @ts-ignore
function unstringifyBigInts(o) {
  if (typeof o === "string" && /^[0-9]+$/.test(o)) {
    // @ts-ignore
    return BigInt(o);
  } else if (typeof o === "string" && /^0x[0-9a-fA-F]+$/.test(o)) {
    // @ts-ignore
    return BigInt(o);
  } else if (Array.isArray(o)) {
    return o.map(unstringifyBigInts);
  } else if (typeof o === "object") {
    if (o === null) return null;
    const res = {};
    const keys = Object.keys(o);
    keys.forEach((k) => {
      // @ts-ignore
      res[k] = unstringifyBigInts(o[k]);
    });
    return res;
  } else {
    return o;
  }
}

// @ts-ignore
const grothProof = async (Input, wasm, zkey) => {
  const { proof, publicSignals } = await groth16.fullProve(Input, wasm, zkey);

  console.log("\n my pub signals are: ", publicSignals, "\n");

  const editedPublicSignals = unstringifyBigInts(publicSignals);
  const editedProof = unstringifyBigInts(proof);
  const calldata = await groth16.exportSolidityCallData(
    editedProof,
    editedPublicSignals
  );

  const argv = calldata
    .replace(/["[\]\s]/g, "")
    .split(",")
    // @ts-ignore
    .map((x) => BigInt(x).toString());

  const a = [argv[0], argv[1]];
  const b = [
    [argv[2], argv[3]],
    [argv[4], argv[5]],
  ];
  const c = [argv[6], argv[7]];
  const input = argv.slice(8);

  return { a, b, c, input };
};

describe("Deposit", function () {
  // @ts-ignore
  let deposit;

  beforeEach(async function () {
    // const PoseidonT3 = await ethers.getContractFactory(
    //   poseidonContract.generateABI(2),
    //   poseidonContract.createCode(2)
    // );
    // const poseidonT3 = await PoseidonT3.deploy();
    // await poseidonT3.deployed();

    const DepositVerifier = await ethers.getContractFactory("DepositVerifier", {
      // libraries: {
      //   PoseidonT3: poseidonT3.address,
      // },
    });
    deposit = await DepositVerifier.deploy();
    await deposit.deployed();
  });

  it("check deposit", async () => {
    const { a, b, c, input } = await grothProof(
      {
        currentBalnace: 10,
        identityCommitment: 21,
        value: 45,
      },
      "circuits/Deposit/deposit_js/deposit.wasm",
      "circuits/Deposit/circuit_final.zkey"
    );

    console.log("\nthis is my inputs inside contract:, ", input, "\n");

    // @ts-ignore
    const isValid = await deposit.verifyProof(a, b, c, input);

    // @ts-ignore
    expect(isValid).to.be.true;
  });
});
