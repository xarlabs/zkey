# Garaga Setup Guide

To get started with Garaga, ensure you have the following prerequisites installed:

- **Python 3.10** (accessible via the `python3.10` command in your terminal)
- **[Scarb](https://docs.swmansion.com/scarb/download.html)** version 2.8.2
- **[Rust](https://www.rust-lang.org/tools/install)**

## Installation Steps

1. **Clone the Repository**

   Begin by cloning the Garaga repository:

   ```bash
   git clone https://github.com/xarlabs/zkey.git
   ```

2. **Navigate to the Garaga Directory**

   Change into the Garaga directory:

   ```bash
   cd zkey/garaga
   ```

3. **Run Setup**

   Execute the setup script:

   ```bash
   make setup
   ```

4. **Activate the Virtual Environment**

   Activate the virtual environment that was created during setup:

   ```bash
   source venv/bin/activate
   ```

5. **Install Additional Dependencies**

   For this fork, install the `grpcio` and `ujson` packages:

   ```bash
   pip install grpcio ujson
   ```

6. **Run the service**
    Navigate to the groth16_contract_generator directory and run the calldata.py script
    ```bash
    cd garaga/hydra/garaga/starknet/groth16_contract_generator
    python3 calldata.py
    ```


If everything completes successfully, you're all set!
