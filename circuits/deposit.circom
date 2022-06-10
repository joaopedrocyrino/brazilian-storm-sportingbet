pragma circom 2.0.0;

include "../node_modules/circomlib/circuits/poseidon.circom";

template Deposit() {
    signal input identityCommitment;
    signal input currentBalnace;
    signal input value;

    signal output hashs[3];
    signal newBalance;

    newBalance <== value + currentBalnace;

    component hashers[3];

    for (var i = 0; i < 3; i++) {
        hashers[i] = Poseidon(1);
    }

    hashers[0].inputs[0] <== identityCommitment;
    hashers[1].inputs[0] <== currentBalnace;
    hashers[2].inputs[0] <== newBalance;

    for (var i = 0; i < 3; i++) {
        hashs[i] <== hashers[i].out;
    }
}

component main {public [value]} = Deposit();