pragma circom 2.0.0;

include "../node_modules/circomlib/circuits/poseidon.circom";
include "../node_modules/circomlib/circuits/comparators.circom";
include "../node_modules/circomlib/circuits/mux1.circom";

template MerkleTreeInclusionProof(n) {
    signal input identityCommitment;
    signal input path_elements[n];
    signal input path_index[n];
    signal output root;
    signal output identityCommitmentHash;

    component hashers[n];
    component mux[n];

    component hashIdentity = Poseidon(1);
    hashIdentity.inputs[0] <== identityCommitment;

    signal hashs[n + 1];
    hashs[0] <== hashIdentity.out;

    for (var i = 0; i < n; i++) {
        hashers[i] = Poseidon(2);
        mux[i] = MultiMux1(2);

        mux[i].c[0][1] <== path_elements[i];
        mux[i].c[1][0] <== path_elements[i];

        mux[i].c[0][0] <== hashs[i];
        mux[i].c[1][1] <== hashs[i];

        mux[i].s <== path_index[i];

        hashers[i].inputs[0] <== mux[i].out[0];
        hashers[i].inputs[1] <== mux[i].out[1];

        hashs[i + 1] <== hashers[i].out;
    }

    root <== hashs[n];
    identityCommitmentHash <== hashIdentity.out;
}

component main = MerkleTreeInclusionProof(32);