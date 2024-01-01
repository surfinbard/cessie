module DataMemoModule
import types::*;
(   
    input  [0:5]    address,
    input  bus_type input_data,
    input           clk, 
                    enable_read,
                    enable_write,
    output bus_type read_data
);
    
reg bus_type registers[0:31];

always @(posedge clk) begin
  if (enable_write) registers[address] <= input_data;     
end

always @(*) begin
  if (enable_read) read_data <= registers[address];
  else read_data <= 0;
  //should it change to zero or keep last value?
end

endmodule : DataMemoModule
