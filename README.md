# Brazilian Storm Sportingbet <!-- omit in toc -->

Brazilian Storm Sportingbet is a platform that allows users to bet on brazilian soccer matches using zk to hide users balance and bets values.


The project is currently on [Harmony Devnet](https://explorer.ps.hmny.io/)

Brazilian Storm Sportingbet has 3 bet options so far: Winner where a user bets on who will win the match, Score where a user bets on the match score and Goal where the user bets on how many goals one specific team will score.

<!-- Brazilian Storm Sportingbet Demo Video:

https://youtu.be -->

## Table of Contents <!-- omit in toc -->

- [Project Structure](#project-structure)
  - [api](#api)
  - [contracts](#contracts)
- [Run Locally](#run-locally)
  - [Clone the Repository](#clone-the-repository)
  - [Run circuits](#run-circuits)
  - [Run contracts](#run-contracts)
  - [Run api](#run-api)
  - [Run ui](#run-ui)

## Project Structure

The project has three main folders:

- api
- contracts
- ui

### api

The [api folder](/api/) contains the api responsible to fullfill data to the smart contract.


### contracts

The [contracts folder](/contracts/) contains all the smart contracts and circuits used in Brazilian Storm Sportingbet.

### ui

The [ui folder](/ui/) contains Brazilian Storm Sportingbet's ui.


## Run Locally

### Clone the Repository

```bash
git clone https://github.com/joaopedrocyrino/brazilian-storm-sportingbet.git
```

### Run api

To run api:

```bash
cd api
```

```bash
yarn dev
```

### Run contracts

To run contracts:

```bash
cd contracts
```

```bash
yarn local
```

### Run ui

To run ui:

```bash
cd ui
```

```bash
yarn dev
```