module RegFile
  import types::*;
(   
    input [0:5]  read_addr_1,
                 read_addr_2,
                 write_addr,
    input  bus_t data,
    input        clk, 
                 enable,
    output bus_t fetched_value_1,
                 fetched_value_2
);
    reg bus_t registers[0:31];

  always @(posedge clk) begin
    if (enable & write_addr != '0) registers[write_addr] <= data;
  end

  assign fetched_value_1 = registers[read_addr_1];
  assign fetched_value_2 = registers[read_addr_2];

endmodule : RegFile
