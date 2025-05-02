# MIPS32 Processor Subset

## Overview

This project features a MIPS processor core implemented in SystemVerilog. Key components such as the ALU, register file, data and instruction memories, and control units are created and integrated. The processor's functionality is enhanced with additional instructions like `ADDI` and `BNE`.

## Features

* **ALU** for arithmetic and logic operations
* **Register File** with 32 registers
* **Memory** for data and instructions
* **Control Unit** for instruction decoding
* **Test-driven development (TDD)** using cocotb and Python
* **Simulation** with Icarus Verilog, Verilator, and GTKWave

## Tools Used

* **SystemVerilog** for hardware description
* **Python** and **cocotb** for testbenches
* **Icarus Verilog** and **Verilator** for simulation
* **GTKWave** for waveform visualization
* **MARS** for MIPS assembly programming

## Installation

1. Clone the repository.
2. Set up a virtual environment for Python and install dependencies.
3. Use `make` to compile and simulate the design.

## Testing

The processor is validated through a Fibonacci sequence algorithm written in C, compiled into MIPS Assembly, and executed on the processor.

---

You can customize this further depending on your repository structure and specific project details!
