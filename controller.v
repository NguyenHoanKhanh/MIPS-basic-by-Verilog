`ifndef CONTROLLER_V
`define CONTROLLER_V

module controller (
    opcode, Reg_Dst, Reg_Write, Alu_Src, Alu_Control, Mem_Write, Mem_Read, Mem_To_Reg
);
    input [5 : 0] opcode;
    output reg Reg_Dst, Reg_Write, Alu_Src, Mem_Write, Mem_Read, Mem_To_Reg;
    output reg [2 : 0] Alu_Control;
    parameter ADD = 6'b000001, LW = 6'b000010, SW = 6'b000100;

    always @(*) begin
        case (opcode)
            ADD : begin
                Reg_Dst = 1'b1;
                Reg_Write = 1'b1;
                Alu_Src = 1'b0;
                Alu_Control = 3'b101;
                Mem_Write = 1'b0;
                Mem_Read = 1'b0;
                Mem_To_Reg = 1'b1;
            end
            LW : begin
                Reg_Dst = 1'b0;
                Reg_Write = 1'b1;
                Alu_Src = 1'b1;
                Alu_Control = 3'b101;
                Mem_Write = 1'b0;
                Mem_Read = 1'b1;
                Mem_To_Reg = 1'b0;
            end
            SW : begin
                Reg_Dst = 1'b0;
                Reg_Write = 1'b0;
                Alu_Src = 1'b1;
                Alu_Control = 3'b101;
                Mem_Write = 1'b1;
                Mem_Read = 1'b0;
                Mem_To_Reg = 1'b0;
            end
            default : begin
                Reg_Dst = 1'b0;
                Reg_Write = 1'b0;
                Alu_Src = 1'b0;
                Alu_Control = 3'b000;
                Mem_Write = 1'b0;
                Mem_Read = 1'b0;
                Mem_To_Reg = 1'b0;
            end
        endcase
    end
endmodule
`endif 