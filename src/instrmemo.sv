module InstrMemoModule
import types::*;
(   
    input [0:5]  read_addr,
    output bus_type instruction
);

reg bus_type registers[0:31];

assign instruction = registers[read_addr];

endmodule : InstrMemoModule