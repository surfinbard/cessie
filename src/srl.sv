module SrlModule
import types::*;
(
    input  bus_type      a,
    input  offset5_type  b,
    output bus_type      s
);

assign s = a >> b;

endmodule : SrlModule
