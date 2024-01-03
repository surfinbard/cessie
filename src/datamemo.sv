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
    
bus_type registers[0:31];

always @(posedge clk) begin
  if (enable_write) registers[address] <= input_data;     
end

always @(*) begin
  if (enable_read) read_data = registers[address];
  else read_data = 0;
end

endmodule : DataMemoModule
