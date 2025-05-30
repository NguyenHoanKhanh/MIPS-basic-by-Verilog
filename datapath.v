`ifndef DATAPATH_V
`define DATAPATH_V
`include "register.v"
`include "data_memory.v"
`include "ALU.v"


module datapath (
    clk, rst, Instr, Reg_Dst, Reg_Write, Alu_Src, Alu_Control, Mem_Write, Mem_Read, Mem_To_Reg, Data_Out   
);
    input clk, rst;
    input [31 : 0] Instr;
    input Reg_Dst;
    input Reg_Write;
    input Alu_Src; 
    input [2 : 0] Alu_Control;
    input Mem_Write;
    input Mem_Read;
    input Mem_To_Reg;
    output [31 : 0] Data_Out;

    wire [4 : 0] Write_Address;
    wire [31 : 0] Read_Data_1;
    wire [31 : 0] Read_Data_2;
    wire [31 : 0] Sign_extend;
    wire [31 : 0] Data_in_ALU;
    wire [31 : 0] Result_alu;
    wire Overflow;
    wire [31 : 0] Read_Data_Mem;
    wire [31 : 0] Write_Data;
    wire [4 : 0] rs, rt, rd;

    assign rs = Instr[25 : 21];
    assign rt = Instr[20 : 16];
    assign rd = Instr[15 : 11];

    assign Write_Address = (Reg_Dst == 1'b1) ? rd : rt;

    register_file rf (
        .clk(clk), 
        .rst(rst),
        .reg_write(Reg_Write),
        .read_address_1(rs),
        .read_address_2(rt),
        .write_address(Write_Address),
        .write_data(Write_Data),
        .read_data_1(Read_Data_1),
        .read_data_2(Read_Data_2)
    );

    assign Sign_extend = {{16{Instr[15]}}, Instr[15 : 0]};     
    assign Data_in_ALU = (Alu_Src == 1'b1) ? Sign_extend : Read_Data_2;

    ALU al (
        .inp1(Read_Data_1), 
        .inp2(Data_in_ALU), 
        .outp(Result_alu), 
        .sel_alu(Alu_Control), 
        .overflow(Overflow)
    );

    data_memory dm (
        .clk(clk), 
        .rst(rst), 
        .write_data(Read_Data_2), 
        .read_data(Read_Data_Mem), 
        .mem_write(Mem_Write), 
        .mem_read(Mem_Read), 
        .write_address(Result_alu), 
        .read_address(Result_alu)
    );

    assign Write_Data = (Mem_To_Reg == 1'b1) ? Result_alu : Read_Data_Mem;

    assign Data_Out = Write_Data;
endmodule
`endif 