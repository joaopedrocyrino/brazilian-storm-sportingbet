const fs = require("fs");
const solidityRegex = /pragma solidity \^\d+\.\d+\.\d+/;

const verifierRegex = /contract Verifier/;

// const verifyProofRegex = /function verifyProof/;

const contracts = ["MerkleTreeInclusionVerifier", "DepositVerifier"];

contracts.forEach((e) => {
  const content = fs.readFileSync(`./contracts/${e}.sol`, {
    encoding: "utf-8",
  });
  let bumped = content.replace(solidityRegex, "pragma solidity ^0.8.0");
  bumped = bumped.replace(verifierRegex, `contract ${e}`);
  // bumped = bumped.replace(verifyProofRegex, `function ${e}VerifyProof`);

  fs.writeFileSync(`./contracts/${e}.sol`, bumped);
});
