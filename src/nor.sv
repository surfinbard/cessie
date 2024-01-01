module NorModule
import types::*;
(
    input  bus_type a,
                    b,
    output bus_type s
);

assign s = ~(a | b);

endmodule : NorModule
