module ALUControlModule
import types::*;
(
    input  logic [0:1] aluOp,
    input  logic [0:5] funct,
    output logic [0:3] operation
);

always_comb begin
    casez({aluOp, funct})
        8'b00zzzzzz:        operation = ALU_ADD;
        8'b01zzzzzz:        operation = ALU_SUB;
        {2'b10, FUNC_ADD}:  operation = ALU_ADD;
        {2'b10, FUNC_SUB}:  operation = ALU_SUB;
        {2'b10, FUNC_AND}:  operation = ALU_AND;
        {2'b10, FUNC_OR}:   operation = ALU_OR;
        {2'b10, FUNC_SLT}:  operation = ALU_SLT;
        default:            operation = ALU_ADD;
    endcase
end

endmodule : ALUControlModule
