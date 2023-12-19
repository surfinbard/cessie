module ALUControlModule
import types::*;
(
    input  logic [0:1] aluOp,
    input  logic [0:5] funct,
    output logic [0:3] operation
);

always_comb begin
    casez({aluOp, funct})
        8'b00zzzzzz:        operation = ULA_ADD;
        8'b01zzzzzz:        operation = ULA_SUB;
        {2'b10, FUNC_ADD}:  operation = ULA_ADD;
        {2'b10, FUNC_SUB}:  operation = ULA_SUB;
        {2'b10, FUNC_AND}:  operation = ULA_AND;
        {2'b10, FUNC_OR}:   operation = ULA_OR;
        {2'b10, FUNC_SLT}:  operation = ULA_SLT;
        default:            operation = ULA_ADD;
    endcase
end

endmodule : ALUControlModule
