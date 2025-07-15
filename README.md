## 📋 Table of Contents :

1. [Project Overview](#project-overview)

2. [Key Features](#key-features)

3. [Architecture & Pipeline Stages](#architecture-pipeline-stages)

4. [Instruction Set](#instruction-set)

5. [Module Breakdown](#module-breakdown)

6. [Getting Started](#getting-started)

7. [Simulation & Testbench](#simulation-testbench)

8. [Usage Example](#usage-example)

9. [Future Improvements](#future-improvements)

10. [Contributing](#contributing)

## 📝 Project overview :
A 32-bit MIPS-style processor implemented in Verilog with a clean, modular pipeline design. This project aims to provide an educational platform for understanding the fundamental components and data flow of a MIPS processor, including instruction fetch, decode, execution, memory access, and write-back.

Key goals:

• Illustrate core processor pipeline concepts

• Simplify interfacing for in-class simulation

• Offer extensibility for custom instructions and enhancements

## 🚀 Key Feature : 
• Custom Logic Parsing: Tailored 32-bit MIPS instruction formats to align with course requirements.

• Optimized Resource Usage: Streamlined modules minimize combinational logic without sacrificing clarity.

• Extended Instruction Set: Implements additional arithmetic, logic, and shift operations beyond the basic MIPS subset.

• Modular Design: Separate modules for control, datapath, ALU, register file, and data memory improve maintainability.

## 🏗️ Architecture & Pipeline Stages : 
The processor is organized into five primary stages: 

1. Instruction Fetch (IF) in  [`processor.v`](https://github.com/NguyenHoanKhanh/MIPS-basic-by-Verilog/blob/main/processor.v)) :
Instructions are fetched from an external source. Due to limitations in interfacing with external files (e.g., .txt), the testbench is used to directly inject instructions for simulation purposes.

2. Instruction Decode (ID) in [`controller.v`](https://github.com/NguyenHoanKhanh/MIPS-basic-by-Verilog/blob/main/controller.v)):
This stage decodes the instruction to extract register addresses. It retrieves the source register values from the register file, extends immediate values using the extension unit, and forwards the opcode to the control unit. The decoding and control logic are integrated within the control unit.

3. Execution stage (EX) in [`ALU.v`](https://github.com/NguyenHoanKhanh/MIPS-basic-by-Verilog/blob/main/ALU.v) and [`datapath.v`](https://github.com/NguyenHoanKhanh/MIPS-basic-by-Verilog/blob/main/datapath.v)):
Supports various operations including arithmetic (ADD, SUB, increment, decrement), logic (AND, OR, XOR, complement), comparison, and shift operations (shift left, shift right).

4. Memory stage in [`data_memory.v`](https://github.com/NguyenHoanKhanh/MIPS-basic-by-Verilog/blob/main/data_memory.v)):
Handles memory access operations for load and store instructions. It stores computed results and forwards them to the destination register (rd) for write-back.

5. Write - back stage (WB) :

Data from MEM or ALU result written back into the register file.

## ✅ Evaluation : 
After the project, student can understand and construct a fundamental architectur of MIPS 32 bit.
The project may be need to improve in Instruction Fetch to fetching instructions easier than the current version.
