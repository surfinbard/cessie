module SltModule
  import types::*;
(
    input  bus_t a,
                 b,
                 slt_sel,
    output bus_t s
);

  wire signed [0:31] signed_a, signed_b;

  assign signed_a = signed'(a);
  assign signed_b = signed'(b);

  always_comb begin
    if (slt_sel) 
      s = (a < b) ? '1 : '0;
    else 
      s = (signed_a < signed_b) ? '1 : '0;
  end 

endmodule : SltModule
