module ALUModule
import types::*;
(
    input   bus_type        a, b,
    input   alu_oper_type   sel,
    output  bus_type        s,
    output  logic           zero    
);

reg unsigned_slt;
bus_type results_and, results_or, results_add, results_sub, results_slt, results_nor;

AndModule and_instance(.a(a), .b(b), .s(results_and));

OrModule or_instance(.a(a), .b(b), .s(results_or));

AddModule add_instance(.a(a), .b(b), .s(results_add));

SubModule sub_instance(.a(a), .b(b), .s(results_sub));

SltModule slt_instance(.a(a), .b(b), .unsigned_slt(unsigned_slt), .s(results_slt));

NorModule nor_instance(.a(a), .b(b), .s(results_nor));

assign unsigned_slt = sel == ALU_SLT ? 0 : 1;

assign zero = s == 32'b0 ? 1 : 0;

always_comb begin
    case(sel)
        ALU_ADD:            s = results_add;
        ALU_SUB:            s = results_sub;
        ALU_SLT, ALU_SLTU:  s = results_slt;
        ALU_AND:            s = results_and;
        ALU_OR:             s = results_or;
        ALU_NOR:            s = results_nor;
        default:            s = results_and;
    endcase
end

endmodule : ALUModule
