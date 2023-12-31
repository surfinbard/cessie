module ArithmeticModule
import types::*;
(
    input bus_type a, b,
    input alu_oper_type sel,
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

assign slt_sel = sel == ALU_SLT ? 0 : 1;

always_comb begin
    case(sel)
        ALU_AND:            s = results_and;
        ALU_OR:             s = results_or;
        ALU_ADD:            s = results_add;
        ALU_SUB:            s = results_sub;
        ALU_SLT, ALU_SLTU:  s = results_slt;
        ALU_NOR:            s = results_nor;
    endcase
    if (s == 4'b000) begin
        zero = 4'b1111;
    end
end

endmodule : ArithmeticModule
