module AddModule
  import types::*;
(
    input  bus_t a,
                 b,
    output bus_t s
);


  assign s = a + b;

endmodule : AddModule
