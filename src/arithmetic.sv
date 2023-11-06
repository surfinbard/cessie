module Aritmethic
import types::*;
(
    input bus_t a, b,
    input oper_t sel,
    output bus_t s,
    output bus_t zero    
);

bus_t results_and, results_or, results_add, results_sub, results_slt, results_nor;

AndModule e(.a(a), .b(b), .s(results_and));

OrModule ou(.a(a), .b(b), .s(results_or));

Add add(.a(a), .b(b), .s(results_add));

Sub sub(.a(a), .b(b), .s(results_sub));

Slt slt(.a(a), .b(b), .s(results_slt));

Nor nor(.a(a), .b(b), .s(results_nor));

always_comb begin
    case(sel)
        AND: s = results_and;
        OR: s = results_or;
        ADD: s = results_add;
        SUB: s = results_sub;
        SLT: s = results_slt;
        NOR: s = results_nor;
    endcase
    if (s == 0') begin
        zero = 1'
    end
end

endmodule : Aritmethic
