## 🧠 About the Project :
Designed and implemented a 32-bit MIPS-style processor in Verilog with a modular architecture including datapath unit, control unit and test bench. This project can handle some instruction fundamental and easy to study how to construct a basic architecture MIPS.

## 🚀 Key Feature : 
• Logic Parsing : Architecture of MIPS 32bit is customed by me to approriate with study in class.

&nbsp;&nbsp;• Optimize some block to restrict the number of blocks too much in the architecture.

&nbsp;&nbsp;• Add some more instructions to the original architecture.

## 🧩 Project Components : 
• Architecture built in order :

&nbsp;&nbsp;• IF stage : Instruction will be fetching from component external. Instruction will be fetching from component external. In my architecture there are some errors that make it impossible to extract commands from external sources such as .txt file, so I use the solution of directly accessing for the testbench.

&nbsp;&nbsp;• ID stage : Decoding to separate address of register necessary and is storaged by register file, if it has immediate value, it will be extend by extention block, and decode opcode send to control block. It is integrate into control block.

&nbsp;&nbsp;• Register File : this block is use to storage value such as address of register sources (rs, rt) to send EX block, and address of destiniation register (rd). 

&nbsp;&nbsp;• EX stage : This block can handle some operation such as add AND, OR, XOR, ADD, SUB, increment, decrement, complement, compare, shift_left, shift_right.

