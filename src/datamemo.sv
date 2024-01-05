module DataMemoModule
import types::*;
(   
    input  bus_type address,
                    input_data,
    input           clk, 
                    enable_read,
                    enable_write,
    output bus_type read_data
);
    
reg [7:0] registers[0:96];

always @(posedge clk) begin
  if (enable_write) {registers[address + 3], registers[address + 2], registers[address + 1], registers[address + 0]} <= input_data;     
end

always @(*) begin
  if (enable_read) read_data = {registers[address + 3], registers[address + 2], registers[address + 1], registers[address + 0]};
  else read_data = 0;
end

endmodule : DataMemoModule
