module ALUControlModule
  import types::*;
(
    input  logic funct,
    output logic operation
);

always_comb begin
    case(funct)
        4'b0000: operation = 0010;
        4'b0010: operation = 0110;
        4'b0100: operation = 0000;
        4'b0101: operation = 0001;
        4'b1010: operation = 0111;
    endcase
end

endmodule : ALUControlModule
