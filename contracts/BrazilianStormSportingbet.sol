//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.4;

import "@zk-kit/incremental-merkle-tree.sol/contracts/IncrementalBinaryTree.sol";
// import "@semaphore-protocol/contracts/interfaces/IVerifier.sol";
// import "@semaphore-protocol/contracts/base/SemaphoreCore.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

import "./MerkleTreeInclusionVerifier.sol";
import "./DepositVerifier.sol";

contract BrazilianStormSportingbet {
    using IncrementalBinaryTree for IncrementalTreeData;
    using Counters for Counters.Counter;

    struct BetOption {
        uint256 id;
        bool open;
        string title;
        string description;
        uint256 returnValue;
    }

    struct Bet {
        uint256 id;
        uint256 betOptionId;
        bool finished;
        bool win;
        uint256 value;
    }

    address private owner;

    // each leaf is an user identity commitment (pub key)
    IncrementalTreeData public users;
    // each leaf is a hash of user identity commitment and its balance
    // IncrementalTreeData public utxos;
    // IncrementalTreeData public deposits;
    // 
    // IncrementalTreeData public transitionUtxos;

    // IVerifier public sempahoreVerifier;
    DepositVerifier public depositVerifier;
    MerkleTreeInclusionVerifier public merkleTreeInclusionVerifier;

    // mapping(uint256 => Bet) public bets;
    mapping(uint256 => bool) public usernames;
    mapping(uint256 => uint256) public balances;
    // mapping(uint256 => uint256) public transitionBalances;
    mapping(uint256 => uint256) public treeIndex;

    constructor(address _depositVerifier, address _merkleTreeVerifier, uint8 depth) {
        // sempahoreVerifier = IVerifier(_verifier);
        depositVerifier = DepositVerifier(_depositVerifier);
        merkleTreeInclusionVerifier = MerkleTreeInclusionVerifier(_merkleTreeVerifier);

        users.init(depth, 0);
        // utxos.init(depth, 0);
        // deposits.init(depth, 0);
        // transitionUtxos.init(depth, 0);

        owner = msg.sender;
    }

    event UserCreated(uint256 identityCommitment, uint256 root);
    event UserDeleted(uint256 identityCommitment, uint256 root);

    // modifier merkleTreeInclusion(
    //     uint256[2] memory a,
    //     uint256[2][2] memory b,
    //     uint256[2] memory c,
    //     uint256[1] memory input
    // ) {
    //     bool isHonestCalculation = merkleTreeInclusionVerifier.verifyProof(
    //         a,
    //         b,
    //         c,
    //         input
    //     );
    //     require(isHonestCalculation && root == users.root, "Not authorized");
    //     _;
    // }

    function createUser(uint256 username, uint256 identityCommitment) external {
        require(!usernames[username], "Username is taken");

        users.insert(identityCommitment);

        uint256 newRoot = users.root;

        emit UserCreated(identityCommitment, newRoot);
    }

    function deposit(
        uint256[2] memory merkleA,
        uint256[2][2] memory merkleB,
        uint256[2] memory merkleC,
        uint256[2] memory merkleInput,
        uint256[2] memory depositA,
        uint256[2][2] memory depositB,
        uint256[2] memory depositC,
        uint256[4] memory depositInput
    ) external payable {
        bool isIncluded = merkleTreeInclusionVerifier.verifyProof(
            merkleA,
            merkleB,
            merkleC,
            merkleInput
        );

        require(isIncluded && input[0] == users.root, "Not authorized");

        bool isValidDeposit = depositVerifier.verifyProof(
            depositA,
            depositB,
            depositC,
            depositInput
        );
        
        require(isValidDeposit && balances[depositInput[0]] == depositInput[1] && msg.value == depositInput[3], "Invalid deposit");

        balances[depositInput[0]] = depositInput[2];
    }

    // modifier onlyOwner() {
    //     require(msg.sender == owner, "Caller is not the owner");
    //     _;
    // }

    // modifier verifySemaphore(
    //     bytes32 signal,
    //     uint256 root,
    //     uint256 nullifierHash,
    //     uint256 externalNullifier,
    //     uint256[8] calldata proof
    // ) {
    //     _verifyProof(
    //         signal,
    //         root,
    //         nullifierHash,
    //         externalNullifier,
    //         proof,
    //         sempahoreVerifier
    //     );

    //     require(root == users.root, "Not authorized");
    //     _;
    // }

    // function deleteUser(
    //     bytes32 signal,
    //     uint256 nullifierHash,
    //     uint256[8] calldata proof,
    //     uint256 identityCommitment,
    //     uint256[] calldata proofSiblings,
    //     uint8[] calldata proofPathIndices
    // )
    //     external
    //     verifySemaphore(signal, users.root, nullifierHash, users.root, proof)
    // {
    //     users.remove(identityCommitment, proofSiblings, proofPathIndices);

    //     uint256 newRoot = users.root;

    //     emit UserDeleted(identityCommitment, newRoot);
    // }

    // function createBetOption() external onlyOwner {}

    // function createBet(
    //     bytes32 signal,
    //     uint256 nullifierHash,
    //     uint256[8] calldata proof,
    //     uint256 betOptionId,
    //     uint256 value
    // )
    //     external
    //     verifySemaphore(signal, users.root, nullifierHash, users.root, proof)
    // {
    //     BetOption memory betOpt = betOptions[betOptionId];

    //     require(betOpt.open == true, "This bet option is closed");

    //     uint256 id = _betIds.current();

    //     bets[id] = Bet(id, betOptionId, false, false, value);

    //     _betIds.increment();
    // }

    // function deposit(
    //     bytes32 signal,
    //     uint256 nullifierHash,
    //     uint256[8] calldata proof
    // )
    //     external
    //     verifySemaphore(signal, users.root, nullifierHash, users.root, proof)
    // {}
}
