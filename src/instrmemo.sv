module InstrMemoModule
import types::*;
(   
    input  bus_type read_addr,
    output bus_type instruction
);

bus_type registers[31:0];

assign instruction = registers[read_addr];

endmodule : InstrMemoModule