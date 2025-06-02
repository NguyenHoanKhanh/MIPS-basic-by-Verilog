`ifndef CONTROLLER_V
`define CONTROLLER_V

module controller (
    opcode, Reg_Dst, Reg_Write, Alu_Src, Alu_Control, Mem_Write, Mem_Read, Mem_To_Reg, Shamt_Sel
);
    input [5 : 0] opcode;
    output reg Reg_Dst, Reg_Write, Alu_Src, Mem_Write, Mem_Read, Mem_To_Reg, Shamt_Sel;
    output reg [3 : 0] Alu_Control;
    parameter ADD = 6'b000001, SUB = 6'b000010, INC = 6'b000011, DEC = 6'b000100, AND = 6'b000101, OR = 6'b000110, XOR = 6'b000111, NOT = 6'b001000, SHIFT_LEFT = 6'b001001, SHIFT_RIGHT = 6'b001010, LW = 6'b100010, SW = 6'b100100;

    always @(*) begin
        case (opcode)
            ADD : begin
                Reg_Dst = 1'b1;
                Reg_Write = 1'b1;
                Alu_Src = 1'b0;
                Alu_Control = 4'b0101;
                Mem_Write = 1'b0;
                Mem_Read = 1'b0;
                Mem_To_Reg = 1'b1;
                Shamt_Sel = 1'b0;
            end
            SUB : begin
                Reg_Dst = 1'b1;
                Reg_Write = 1'b1;
                Alu_Src = 1'b0;
                Alu_Control = 4'b0110;
                Mem_Write = 1'b0;
                Mem_Read = 1'b0;
                Mem_To_Reg = 1'b1;
                Shamt_Sel = 1'b0;
            end
            INC : begin
                Reg_Dst = 1'b1;
                Reg_Write = 1'b1;
                Alu_Src = 1'b0;
                Alu_Control = 4'b0111;
                Mem_Write = 1'b0;
                Mem_Read = 1'b0;
                Mem_To_Reg = 1'b1;
                Shamt_Sel = 1'b0;
            end
            DEC : begin
                Reg_Dst = 1'b1;
                Reg_Write = 1'b1;
                Alu_Src = 1'b0;
                Alu_Control = 4'b0100;
                Mem_Write = 1'b0;
                Mem_Read = 1'b0;
                Mem_To_Reg = 1'b1;
                Shamt_Sel = 1'b0;
            end
            AND : begin
                Reg_Dst = 1'b1;
                Reg_Write = 1'b1;
                Alu_Src = 1'b0;
                Alu_Control = 4'b0001;
                Mem_Write = 1'b0;
                Mem_Read = 1'b0;
                Mem_To_Reg = 1'b1;
                Shamt_Sel = 1'b0;
            end
            OR : begin
                Reg_Dst = 1'b1;
                Reg_Write = 1'b1;
                Alu_Src = 1'b0;
                Alu_Control = 4'b0011;
                Mem_Write = 1'b0;
                Mem_Read = 1'b0;
                Mem_To_Reg = 1'b1;
                Shamt_Sel = 1'b0;
            end
            XOR : begin
                Reg_Dst = 1'b1;
                Reg_Write = 1'b1;
                Alu_Src = 1'b0;
                Alu_Control = 4'b0010;
                Mem_Write = 1'b0;
                Mem_Read = 1'b0;
                Mem_To_Reg = 1'b1;
                Shamt_Sel = 1'b0;
            end
            NOT : begin
                Reg_Dst = 1'b1;
                Reg_Write = 1'b1;
                Alu_Src = 1'b0;
                Alu_Control = 4'b0000;
                Mem_Write = 1'b0;
                Mem_Read = 1'b0;
                Mem_To_Reg = 1'b1;
                Shamt_Sel = 1'b0;
            end
            SHIFT_LEFT : begin
                Reg_Dst = 1'b1;
                Reg_Write = 1'b1;
                Mem_Read = 1'b0;
                Mem_Write = 1'b0;
                Mem_To_Reg = 1'b1;
                Alu_Src = 1'b0;
                Shamt_Sel = 1'b1;
                Alu_Control = 4'b1001;
            end
            SHIFT_RIGHT : begin
                Reg_Dst = 1'b1;
                Reg_Write = 1'b1;
                Mem_Read = 1'b0;
                Mem_Write = 1'b0;
                Mem_To_Reg = 1'b1;
                Alu_Src = 1'b0;
                Shamt_Sel = 1'b1;
                Alu_Control = 4'b1010;
            end
            LW : begin
                Reg_Dst = 1'b0;
                Reg_Write = 1'b1;
                Alu_Src = 1'b1;
                Alu_Control = 3'b101;
                Mem_Write = 1'b0;
                Mem_Read = 1'b1;
                Mem_To_Reg = 1'b0;
                Shamt_Sel = 1'b0;
            end
            SW : begin
                Reg_Dst = 1'b0;
                Reg_Write = 1'b0;
                Alu_Src = 1'b1;
                Alu_Control = 3'b101;
                Mem_Write = 1'b1;
                Mem_Read = 1'b0;
                Mem_To_Reg = 1'b0;
                Shamt_Sel = 1'b0;
            end
            default : begin
                Reg_Dst = 1'b0;
                Reg_Write = 1'b0;
                Alu_Src = 1'b0;
                Alu_Control = 3'b000;
                Mem_Write = 1'b0;
                Mem_Read = 1'b0;
                Mem_To_Reg = 1'b0;
                Shamt_Sel = 1'b0;
            end
        endcase
    end
endmodule
`endif 