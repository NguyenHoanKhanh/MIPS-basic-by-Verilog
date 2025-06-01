`ifndef PROCESSOR_V
`define PROCESSOR_V
`include "datapath.v"
`include "controller.v"
module processor ();
    reg clk, rst;
    reg [31 : 0] Instr;
    wire [31 : 0] Data_Out; 
    
    wire Reg_Dst, Reg_Write, Alu_Src, Mem_Write, Mem_Read, Mem_To_Reg;
    wire [2 : 0] Alu_Control;
    parameter ADD = 6'b000001, LW = 6'b000010, SW = 6'b000100;


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
        .Data_Out(Data_Out)
    );

    controller ct (
        .opcode(Instr[31 : 26]),
        .Reg_Dst(Reg_Dst), 
        .Reg_Write(Reg_Write), 
        .Alu_Src(Alu_Src), 
        .Alu_Control(Alu_Control), 
        .Mem_Write(Mem_Write), 
        .Mem_Read(Mem_Read), 
        .Mem_To_Reg(Mem_To_Reg)
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
    Instr = {LW, 5'd1, 5'd0, 16'd0};
    @(posedge clk);
    Instr = {LW, 5'd2, 5'd1, 16'd1};
    @(posedge clk);
    Instr = {ADD, 5'd0, 5'd1, 5'd3, 11'd0};
    @(posedge clk);
    Instr = {LW, 5'd4, 5'd0, 16'd2};
    @(posedge clk);
    Instr = {LW, 5'd5, 5'd4, 16'd3};
    @(posedge clk);
    Instr = {ADD, 5'd0, 5'd4, 5'd5, 11'd0};
    @(posedge clk);
    Instr = {LW, 5'd7, 5'd0, 16'd4};
    @(posedge clk);
    Instr = {LW, 5'd8, 5'd7, 16'd5};
    @(posedge clk);
    Instr = {ADD, 5'd9, 5'd7, 5'd8, 11'd0};
    @(posedge clk);
    Instr = {LW, 5'd10, 5'd0, 16'd6};
    @(posedge clk);
    Instr = {LW, 5'd11, 5'd10, 16'd7};
    @(posedge clk);
    Instr = {ADD, 5'd12, 5'd10, 5'd11, 11'd0};
    @(posedge clk);
    Instr = {LW, 5'd13, 5'd0, 16'd8};
    @(posedge clk);
    Instr = {LW, 5'd14, 5'd13, 16'd9};
    @(posedge clk);
    Instr = {ADD, 5'd15, 5'd13, 5'd14, 11'd0};
    @(posedge clk);
    Instr = {LW, 5'd16, 5'd0, 16'd10};
    @(posedge clk);
    Instr = {LW, 5'd17, 5'd16, 16'd0};
    @(posedge clk);
    Instr = {ADD, 5'd18, 5'd16, 5'd17, 11'd0};
    @(posedge clk);
    Instr = {LW, 5'd19, 5'd0, 16'd1};
    @(posedge clk);
    Instr = {LW, 5'd20, 5'd19, 16'd2};
    @(posedge clk);
    Instr = {ADD, 5'd21, 5'd19, 5'd20, 11'd0};
    @(posedge clk);
    Instr = {LW, 5'd22, 5'd0, 16'd3};
    @(posedge clk);
    Instr = {LW, 5'd23, 5'd22, 16'd4};
    @(posedge clk);
    Instr = {ADD, 5'd24, 5'd22, 5'd23, 11'd0};
    @(posedge clk);
    Instr = {LW, 5'd25, 5'd0, 16'd5};
    @(posedge clk);
    Instr = {LW, 5'd26, 5'd25, 16'd6};
    @(posedge clk);
    Instr = {ADD, 5'd27, 5'd25, 5'd26, 11'd0};
    @(posedge clk);
    Instr = {LW, 5'd28, 5'd0, 16'd7};
    @(posedge clk);
    Instr = {LW, 5'd29, 5'd28, 16'd8};
    @(posedge clk);
    Instr = {ADD, 5'd30, 5'd28, 5'd29, 11'd0};
    @(posedge clk);
    Instr = {LW, 5'd31, 5'd0, 16'd9};
    @(posedge clk);
    Instr = {LW, 5'd0, 5'd31, 16'd10}; // reuse 0
    @(posedge clk);
    Instr = {ADD, 5'd1, 5'd31, 5'd0, 11'd0};

    // Repeat same pattern with reduced immediates
    @(posedge clk);
    Instr = {LW, 5'd2, 5'd0, 16'd0};
    @(posedge clk);
    Instr = {LW, 5'd3, 5'd2, 16'd1};
    @(posedge clk);
    Instr = {ADD, 5'd4, 5'd2, 5'd3, 11'd0};
    @(posedge clk);
    Instr = {SW, 5'd4, 5'd0, 16'd2};
    @(posedge clk);
    Instr = {LW, 5'd5, 5'd0, 16'd3};
    @(posedge clk);
    Instr = {LW, 5'd6, 5'd5, 16'd4};
    @(posedge clk);
    Instr = {ADD, 5'd7, 5'd5, 5'd6, 11'd0};
    @(posedge clk);
    Instr = {SW, 5'd7, 5'd0, 16'd5};
    @(posedge clk);
    Instr = {LW, 5'd8, 5'd0, 16'd6};
    @(posedge clk);
    Instr = {LW, 5'd9, 5'd8, 16'd7};
    @(posedge clk);
    Instr = {ADD, 5'd10, 5'd8, 5'd9, 11'd0};
    @(posedge clk);
    Instr = {SW, 5'd10, 5'd0, 16'd8};
    @(posedge clk);
    Instr = {LW, 5'd11, 5'd0, 16'd9};
    @(posedge clk);
    Instr = {LW, 5'd12, 5'd11, 16'd10};
    @(posedge clk);
    Instr = {ADD, 5'd13, 5'd11, 5'd12, 11'd0};
    @(posedge clk);
    Instr = {SW, 5'd13, 5'd0, 16'd0};
    @(posedge clk);
    Instr = {LW, 5'd14, 5'd0, 16'd1};
    @(posedge clk);
    Instr = {LW, 5'd15, 5'd14, 16'd2};
    @(posedge clk);
    Instr = {ADD, 5'd16, 5'd14, 5'd15, 11'd0};
    @(posedge clk);
    Instr = {SW, 5'd16, 5'd0, 16'd3};
    @(posedge clk);
    Instr = {LW, 5'd17, 5'd0, 16'd4};
    @(posedge clk);
    Instr = {LW, 5'd18, 5'd17, 16'd5};
    @(posedge clk);
    Instr = {ADD, 5'd19, 5'd17, 5'd18, 11'd0};
    @(posedge clk);
    Instr = {SW, 5'd19, 5'd0, 16'd6};
    @(posedge clk);
    Instr = {LW, 5'd20, 5'd0, 16'd7};
    @(posedge clk);
    Instr = {LW, 5'd21, 5'd20, 16'd8};
    @(posedge clk);
    Instr = {ADD, 5'd22, 5'd20, 5'd21, 11'd0};
    @(posedge clk);
    Instr = {SW, 5'd22, 5'd0, 16'd9};
    @(posedge clk);
    Instr = {LW, 5'd23, 5'd0, 16'd10};
    @(posedge clk);
    Instr = {LW, 5'd24, 5'd23, 16'd0};
    @(posedge clk);
    Instr = {ADD, 5'd25, 5'd23, 5'd24, 11'd0};
    @(posedge clk);
    Instr = {SW, 5'd25, 5'd0, 16'd1};

    #20;
    $finish;

end

endmodule
`endif