module RegFileModule
import types::*;
(   
    input [0:5]     read_addr_1,
                    read_addr_2,
                    write_addr,
    input  bus_type input_data,
    input           clk, 
                    enable,
    output bus_type fetched_value_1,
                    fetched_value_2
);

reg bus_type registers[0:31];

always @(posedge clk) begin
  if (enable) registers[write_addr] <= input_data; 
end

assign fetched_value_1 = read_addr_1 == 0 ? 0 : registers[read_addr_1];
assign fetched_value_2 = read_addr_2 == 0 ? 0 : registers[read_addr_2];

endmodule : RegFileModule
