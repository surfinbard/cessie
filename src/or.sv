module OrModule
import types::*;
(
    input  bus_type a,
                    b,
    output bus_type s
);

always_comb s = a | b;

endmodule : OrModule
