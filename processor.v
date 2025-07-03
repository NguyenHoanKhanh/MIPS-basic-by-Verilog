`ifndef PROCESSOR_V
`define PROCESSOR_V
`include "datapath.v"
`include "controller.v"
module processor;
    reg clk, rst;
    reg [31 : 0] Instr;
    wire [31 : 0] Data_Out; 
    
    wire Reg_Dst, Reg_Write, Alu_Src, Mem_Write, Mem_Read, Mem_To_Reg, Shamt_Sel;
    wire [3 : 0] Alu_Control;
    parameter ADD = 6'b000001, ADDI = 6'b001011, SUB = 6'b000010, SUBI = 6'b001100, INC = 6'b000011, DEC = 6'b000100, AND = 6'b000101, OR = 6'b000110, XOR = 6'b000111, NOT = 6'b001000, SHIFT_LEFT = 6'b001001, SHIFT_RIGHT = 6'b001010, LW = 6'b100010, SW = 6'b100100, COMPARE = 6'b001101;

    datapath dp (
        .clk(clk),
        .rst(rst),
        .Instr(Instr),
        .Reg_Dst(Reg_Dst),
        .Reg_Write(Reg_Write),
        .Alu_Src(Alu_Src),
        .Alu_Control(Alu_Control),
        .Mem_Write(Mem_Write),
        .Mem_Read(Mem_Read),
        .Mem_To_Reg(Mem_To_Reg),
        .Data_Out(Data_Out), 
        .Shamt_Sel(Shamt_Sel)
    );

    controller ct (
        .opcode(Instr[31 : 26]),
        .Reg_Dst(Reg_Dst), 
        .Reg_Write(Reg_Write), 
        .Alu_Src(Alu_Src), 
        .Alu_Control(Alu_Control), 
        .Mem_Write(Mem_Write), 
        .Mem_Read(Mem_Read), 
        .Mem_To_Reg(Mem_To_Reg),
        .Shamt_Sel(Shamt_Sel)
    );

    initial begin
        clk = 1'b0;
        rst = 1'b1;
        #7; rst = 1'b0;
    end
    always #5 clk = ~clk;

    initial begin
        $dumpfile("procee.vcd");
        $dumpvars(0, processor);
    end

    initial begin
        @(negedge rst);
        @(posedge clk);
        //ADD
        Instr = {LW, 5'd1, 5'd0, 16'd1};
        @(posedge clk);
        Instr = {LW, 5'd2, 5'd1, 16'd1};
        @(posedge clk);
        Instr = {ADD, 5'd0, 5'd1, 5'd3, 11'd0};
        @(posedge clk);
        //SUB
        Instr = {LW, 5'd4, 5'd4, 16'd10};
        @(posedge clk);
        Instr = {LW, 5'd5, 5'd5, 16'd9};
        @(posedge clk);
        Instr = {SUB, 5'd4, 5'd5, 5'd6, 11'd0};
        @(posedge clk);
        //INCREASE
        Instr = {LW, 5'd7, 5'd7, 16'd4};
        @(posedge clk);
        Instr = {INC, 5'd7, 5'd9, 16'd0};
        @(posedge clk);
        //DECREASE
        Instr = {LW, 5'd8, 5'd8, 16'd5};
        @(posedge clk);
        Instr = {DEC, 5'd8, 5'd10, 16'd0};
        @(posedge clk);
        //SHIFT LEFT
        Instr = {LW, 5'd11, 5'd11, 16'd5};
        @(posedge clk);
        Instr = {SHIFT_LEFT, 5'd11, 5'd12, 5'd0, 5'd2, 6'd0};
        @(posedge clk);
        //SHIFT RIGHT
        Instr = {LW, 5'd13, 5'd13, 16'd8};
        @(posedge clk);
        Instr = {SHIFT_RIGHT, 5'd13, 5'd14, 5'd0, 5'd2, 6'd0};
        @(posedge clk);
        //AND
        Instr = {LW, 5'd2, 5'd2, 16'd2};
        @(posedge clk);
        Instr = {AND, 5'd2, 5'd1, 5'd15, 11'd0};
        @(posedge clk);
        //OR
        Instr = {OR, 5'd2, 5'd1, 5'd15, 11'd0};
        @(posedge clk);
        //XOR
        Instr = {XOR, 5'd2, 5'd3, 5'd15, 11'd0};
        @(posedge clk);
        //NOT
        Instr = {NOT, 5'd2, 5'd15, 16'd0};
        @(posedge clk);
        //ADDI
        Instr = {ADDI, 5'd2, 5'd15, 16'd1};
        @(posedge clk);
        //SUBI
        Instr = {SUBI, 5'd2, 5'd15, 16'd1};
        //COMPARE
        Instr = {COMPARE, 5'd2, 5'd1, 5'd15, 11'd0};
        #20; $finish;
    end
endmodule
`endif