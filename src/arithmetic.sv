module Aritmethic
import types::*;
(
    input bus_t a, b,
    input ula_oper_t sel,
    output bus_t s,
    output bus_t zero    
);

bus_t slt_sel;
bus_t results_and, results_or, results_add, results_sub, results_slt, results_nor;

AndModule and_instance(.a(a), .b(b), .s(results_and));

OrModule or_instance(.a(a), .b(b), .s(results_or));

AddModule add_instance(.a(a), .b(b), .s(results_add));

SubModule sub_instance(.a(a), .b(b), .s(results_sub));

SltModule slt_instance(.a(a), .b(b), .slt_sel(slt_sel), .s(results_slt));

NorModule nor_instance(.a(a), .b(b), .s(results_nor));

always_comb begin
    //todo update to test signed
    slt_sel = 0;
    case(sel)
        AND:            s = results_and;
        OR:             s = results_or;
        ADD:            s = results_add;
        SUB:            s = results_sub;
        SLT, SLTU:      s = results_slt;
        NOR:            s = results_nor;
    endcase
    if (s == 4'b000) begin
        zero = 4'b1111;
    end
end

endmodule : Aritmethic
