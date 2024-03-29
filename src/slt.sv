module SltModule
import types::*;
(
    input  bus_type a,
                    b,
    input  logic    unsigned_slt,
    output bus_type s
);

wire signed [31:0] signed_a, signed_b;

assign signed_a = signed'(a);
assign signed_b = signed'(b);

always_comb begin
  if (unsigned_slt) 
    s = (a < b) ? '1 : '0;
  else 
    s = (signed_a < signed_b) ? '1 : '0;
end 

endmodule : SltModule
