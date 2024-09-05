# ZKLogin Circuit

## Directory Structure

- **/circuit**: Contains the core circuit files for ZKLogin.
- **/inputs**: Generated input files for the circuit will be stored here.
- **/scripts**: JavaScript scripts to build the circuit inputs.
- **/shell**: Command line files to run the circuit.

## Steps to Run

### a. Installation

First, ensure that you have the following installed:
- Circom version 2.1.6 or higher
- SnarkJS
- Node.js

Then, install the Node.js dependencies by running:
```bash
npm install
```

### b. Generate Nonce Field in JWT

Use the following formula to generate the nonce field in the JWT:

`nonce = Poseidon([pubkey, randomness, exp])`

- `exp` is a user-defined input.

### c. Generate Data File

In `scripts/Generate_data.js`, input the JWT token and run:

```bash
node Generate_data.js
```

This will generate a `data.json` file in the `scripts/` directory.

### d. Generate ZKLogin Input File

In `scripts/input.js`, input the `pubkey`, `randomness`, and `salt`, then run:

```bash
node input.js
```

This command reads the `data.json` file and generates a `ZKLogin.json` file in the `inputs/` directory. This file contains all the necessary inputs for the ZKLogin circuit.

### e. Run the Circuit

Navigate to the `/shell` directory and run the following command:

```bash
./JWT.sh
```

The circuit will begin executing and produce the output.

## Circuit Details

For more detailed information about the circuit, please refer to the comments in `/circuit/ZKLogin.circom`.
