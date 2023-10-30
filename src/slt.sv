module Slt
  import types::*;
(
    input  bus_t a,
                 b,
    output bus_t s,
);

  assign s = a < b ? '1 : '0;

endmodule : Slt
