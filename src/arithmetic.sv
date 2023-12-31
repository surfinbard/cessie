module Aritmethic
import types::*;
(
    input bus_type a, b,
    input ula_oper_type sel,
    output bus_type s,
    output bus_type zero    
);

bus_type slt_sel;
bus_type results_and, results_or, results_add, results_sub, results_slt, results_nor;

AndModule and_instance(.a(a), .b(b), .s(results_and));

OrModule or_instance(.a(a), .b(b), .s(results_or));

AddModule add_instance(.a(a), .b(b), .s(results_add));

SubModule sub_instance(.a(a), .b(b), .s(results_sub));

SltModule slt_instance(.a(a), .b(b), .slt_sel(slt_sel), .s(results_slt));

NorModule nor_instance(.a(a), .b(b), .s(results_nor));

assign slt_sel = sel == ULA_SLT ? 0 : 1;

always_comb begin
    case(sel)
        ULA_AND:            s = results_and;
        ULA_OR:             s = results_or;
        ULA_ADD:            s = results_add;
        ULA_SUB:            s = results_sub;
        ULA_SLT, ULA_SLTU:  s = results_slt;
        ULA_NOR:            s = results_nor;
    endcase
    if (s == 4'b000) begin
        zero = 4'b1111;
    end
end

endmodule : Aritmethic
