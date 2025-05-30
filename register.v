`ifndef REGISTER_V
`define REGISTER_V
module register_file (
    clk, rst, write_data, read_data_1, read_data_2, write_address, read_address_1, read_address_2, reg_write
);
    input clk, rst;
    input reg_write;
    input [4 : 0] write_address;
    input [31 : 0] write_data;
    input [4 : 0] read_address_1, read_address_2;
    output [31 : 0] read_data_1, read_data_2;
    integer i;
    reg [31 : 0] data [31 : 0];

    always @(posedge clk, posedge rst) begin
        if (rst) begin
            for (i = 0; i < 32; i = i + 1) begin
                data[i] <= 32'd0;
            end
        end
        else begin
            if (reg_write) begin
                data[write_address] <= write_data;
            end
        end
    end

    assign read_data_1 = data[read_address_1];
    assign read_data_2 = data[read_address_2];
endmodule

`endif 