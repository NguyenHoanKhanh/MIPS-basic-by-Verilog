## 🧠 About the Project :
Designed and implemented a 32-bit MIPS-style processor in Verilog with a modular architecture consisting of a datapath unit, control unit, and comprehensive testbench. This project supports a set of fundamental instructions and provides a simplified yet educational view into building a basic MIPS processor architecture.

## 🚀 Key Feature : 
• Custom Logic Parsing: The 32-bit MIPS architecture is customized to suit the requirements and constraints of in-class learning.

• Optimized Architecture: Certain components have been optimized to minimize the number of logic blocks used, ensuring clarity and efficiency.

• Extended Instruction Set: Additional instructions beyond the standard MIPS set have been implemented to enhance functionality and experimentation.

## 🧩 Project Components : 
The processor architecture is structured in sequential pipeline stages:

• IF Stage (Instruction Fetch):
Instructions are fetched from an external source. Due to limitations in interfacing with external files (e.g., .txt), the testbench is used to directly inject instructions for simulation purposes.

• ID Stage (Instruction Decode):
This stage decodes the instruction to extract register addresses. It retrieves the source register values from the register file, extends immediate values using the extension unit, and forwards the opcode to the control unit. The decoding and control logic are integrated within the control unit.

• Register File:
Responsible for storing and providing source register values (rs, rt) to the EX stage and for writing back the destination register (rd) values after execution.

• EX Stage (Execution):
Supports various operations including arithmetic (ADD, SUB, increment, decrement), logic (AND, OR, XOR, complement), comparison, and shift operations (shift left, shift right).

• MEM/WB Stage (Memory and Writeback):
Handles memory access operations for load and store instructions. It stores computed results and forwards them to the destination register (rd) for write-back.

After construct that architecture, it will be implement in 
