module OrModule
  import types::*;
(
    input  bus_t a,
                 b,
    output bus_t s
);

  always_comb s = a | b;

endmodule : OrModule
