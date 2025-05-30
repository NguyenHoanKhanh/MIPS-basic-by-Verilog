`ifndef DATA_MEMORY_V
`define DATA_MEMORY_V
module data_memory (
    clk, rst, write_data, read_data, mem_write, mem_read, write_address, read_address
);
    input clk, rst;
    input [31 : 0] write_data;
    input mem_write, mem_read;
    input [31 : 0] write_address, read_address;
    output reg [31 : 0] read_data;
    integer i;
    reg [31 : 0] data [31 : 0];

    always @(negedge clk, posedge rst) begin
        if (rst) begin
            read_data <= 0;
            for (i = 0; i < 32; i = i + 1) begin
                data[i] <= i;
            end
        end
        else begin
            if (mem_write) begin
                data[write_address] <= write_data;
            end
            else if (mem_read) begin
                read_data <= data[read_address];
            end
        end
    end
endmodule
`endif 