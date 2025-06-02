`ifndef LAB4_V
`define LAB4_V

module AND32 (
    inp_1, inp_2, result
);
    input [31 : 0] inp_1, inp_2;
    output [31 : 0] result;

    assign result = inp_1 & inp_2;
endmodule

module OR32 (
    inp_1, inp_2, result
);
    input [31 : 0] inp_1, inp_2;
    output [31 : 0] result;

    assign result = inp_1 | inp_2;
endmodule

module XOR32 (
    inp_1, inp_2, result
);
    input [31 : 0] inp_1, inp_2;
    output [31 : 0] result;

    assign result = inp_1 ^ inp_2;
endmodule


module fullAdder (
    inp_1, inp_2, Cin, Sum, Cout
);
    input inp_1, inp_2;
    input Cin;
    output Sum, Cout;

    assign Sum = inp_1 ^ inp_2 ^ Cin;
    assign Cout = ((inp_1 ^ inp_2) & Cin) | (inp_1 & inp_2);
endmodule

module ADDER_32bit (
    inp_1, inp_2, result, overflow
);
    input [31 : 0] inp_1, inp_2;
    output [31 : 0] result;
    output overflow;
    wire Cout;
    wire [31 : 0] t;
    genvar i;
    assign t[0] = 1'b0;
    generate 
        for(i = 0; i < 31; i = i + 1) begin
            fullAdder fa (.inp_1(inp_1[i]), .inp_2(inp_2[i]), .Cin(t[i]), .Sum(result[i]), .Cout(t[i + 1]));
        end 
        fullAdder fa_last (.inp_1(inp_1[31]), .inp_2(inp_2[31]), .Cin(t[31]), .Sum(result[31]), .Cout(Cout));
    endgenerate

    assign overflow = (Cout ^ t[31]);
endmodule

module ADDER_1bit (
    inp_1, result, overflow
);
    input [31 : 0] inp_1;
    output [31 : 0] result;
    output overflow;   
    wire [31 : 0] inp_2;
    wire Cout;
    wire [31 : 0] t;
    genvar i;

    assign inp_2 = 32'd1;
    assign t[0] = 1'b0;

    generate 
        for(i = 0; i < 31; i = i + 1) begin
            fullAdder fa (.inp_1(inp_1[i]), .inp_2(inp_2[i]), .Cin(t[i]), .Sum(result[i]), .Cout(t[i + 1]));
        end
        fullAdder fa_last (.inp_1(inp_1[31]), .inp_2(inp_2[31]), .Cin(t[31]), .Sum(result[31]), .Cout(Cout));
    endgenerate

    assign overflow = (Cout ^ t[31]);
endmodule

module SUB_32bit (
    inp_1, inp_2, result
);
    input [31 : 0] inp_1, inp_2;
    output [31 : 0] result;
    wire Cout;
    wire [31 : 0] not_inp_2;
    wire [31 : 0] t;
    genvar i;
    assign t[0] = 1'b1;

    generate 
        for (i = 0; i < 32; i = i + 1) begin
            not n (not_inp_2[i], inp_2[i]);
        end
    endgenerate

    generate
        for (i = 0; i < 31; i = i + 1) begin
            fullAdder fa (.inp_1(inp_1[i]), .inp_2(not_inp_2[i]), .Cin(t[i]), .Sum(result[i]), .Cout(t[i + 1]));
        end
        fullAdder fa_last (.inp_1(inp_1[31]), .inp_2(not_inp_2[31]), .Cin(t[31]), .Sum(result[31]), .Cout(Cout));
    endgenerate
endmodule   

module SUB_1bit (
    inp_1, result
);
    input [31 : 0] inp_1;
    output [31 : 0] result;
    wire Cout;
    wire [31 : 0] inp_2;
    genvar i;
    wire [31 : 0] t;
    assign inp_2 = 32'hFFFFFFFF;
    assign t[0] = 1'b0;

    generate 
        for(i = 0; i < 31; i = i + 1) begin
            fullAdder fa (.inp_1(inp_1[i]), .inp_2(inp_2[i]), .Cin(t[i]), .Sum(result[i]), .Cout(t[i + 1]));
        end
        fullAdder fa_last (.inp_1(inp_1[31]), .inp_2(inp_2[31]), .Cin(t[31]), .Sum(result[31]), .Cout(Cout));
    endgenerate
endmodule

module COMPLEMENT (
    inp_1, result
);
    input [31 : 0] inp_1;
    output [31 : 0] result;
    genvar i;
    
    generate 
        for(i = 0; i < 32; i = i + 1) begin
            not n (result[i], inp_1[i]);
        end
    endgenerate
endmodule

module COMPARE (
    inp_1, inp_2, outp
);
    input [31 : 0] inp_1, inp_2;
    output [31 : 0] outp;

    assign outp = (inp_1 == inp_2) ? 32'd1 : 32'd0;
endmodule

module SHIFT_LEFT (
    inp_1, inp_2, outp
);
    input [31 : 0] inp_1;
    input [4 : 0] inp_2;
    output [31 : 0] outp;

    assign outp = inp_1 << inp_2;
endmodule

module SHIFT_RIGHT (
    inp_1, inp_2, outp
);
    input [31 : 0] inp_1;
    input [4 : 0] inp_2;
    output [31 : 0] outp;

    assign outp = inp_1 >> inp_2;
endmodule

module ALU (
    inp_1, inp_2, result, overflow, sel_alu
);
    input [31 : 0] inp_1, inp_2;
    input [3 : 0] sel_alu;
    output reg [31 : 0] result;
    output reg overflow;

    wire [31 : 0] temp_add_32bit, temp_add_1bit, temp_sub_32bit, temp_sub_1bit, temp_and, temp_or, temp_xor, temp_comp, temp_shift_left, temp_shift_right, temp_compare;
    wire overflow_add_32bit, overflow_add_1bit;

    ADDER_32bit a32 (.inp_1(inp_1), .inp_2(inp_2), .result(temp_add_32bit), .overflow(overflow_add_32bit));
    ADDER_1bit a1 (.inp_1(inp_1), .result(temp_add_1bit), .overflow(overflow_add_1bit));
    SUB_32bit s32 (.inp_1(inp_1), .inp_2(inp_2), .result(temp_sub_32bit));
    SUB_1bit s1 (.inp_1(inp_1), .result(temp_sub_1bit));
    AND32 an32 (.inp_1(inp_1), .inp_2(inp_2), .result(temp_and));
    OR32 o32 (.inp_1(inp_1), .inp_2(inp_2), .result(temp_or));
    XOR32 x32 (.inp_1(inp_1), .inp_2(inp_2), .result(temp_xor));
    COMPLEMENT c (.inp_1(inp_1), .result(temp_comp));
    COMPARE cp (.inp_1(inp_1), .inp_2(inp_2), .outp(temp_compare));
    SHIFT_LEFT sl (.inp_1(inp_1), .inp_2(inp_2[4 : 0]), .outp(temp_shift_left));
    SHIFT_RIGHT sr (.inp_1(inp_1), .inp_2(inp_2[4 : 0]), .outp(temp_shift_right));

    always @(*) begin
        if(sel_alu == 4'b0000) begin
            result = temp_comp;
        end
        else if (sel_alu == 4'b0001) begin
            result = temp_and;
        end
        else if (sel_alu == 4'b0010) begin
            result = temp_xor;
        end
        else if (sel_alu == 4'b0011) begin
            result = temp_or;
        end
        else if (sel_alu == 4'b0100) begin
            result = temp_sub_1bit;
        end
        else if (sel_alu == 4'b0101) begin
            result = temp_add_32bit;
            overflow = overflow_add_32bit;
        end
        else if (sel_alu == 4'b0110) begin
            result = temp_sub_32bit;
        end
        else if (sel_alu == 4'b0111) begin
            result = temp_add_1bit;
            overflow = overflow_add_1bit;
        end
        else if (sel_alu == 4'b1000) begin
            result = temp_compare;
        end
        else if (sel_alu == 4'b1001) begin
            result = temp_shift_left;
        end
        else if (sel_alu == 4'b1010) begin
            result = temp_shift_right;
        end
    end
endmodule

`endif