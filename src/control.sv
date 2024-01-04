module ControlModule
import types::*;
(
    input  opcode_type  op,
    output logic        regDst,
                        aluSrc,
                        memToReg,
                        regWrite,
                        memRead,
                        memWrite,
                        branch,
                        jump,
    output logic [1:0]  aluOp            
);

always_comb begin

    jump        = 0;
    regDst      = 1'bx;
    aluSrc      = 1'bx;
    memToReg    = 1'bx;
    regWrite    = 0;
    memRead     = 0;
    memWrite    = 0;
    branch      = 0;
    aluOp       = 2'bxx;

    case(op)
        OP_J: begin
            jump        = 1;
        end
        OP_LW: begin
            regDst      = 0;
            aluSrc      = 1;
            memToReg    = 1;
            regWrite    = 1;
            memRead     = 1;
            aluOp       = 2'b00;
        end     
        OP_SW: begin
            aluSrc      = 1;
            memWrite    = 1;
            aluOp       = 2'b00;
        end      
        OP_BEQ: begin
            aluSrc      = 0;
            branch      = 1;
            aluOp       = 2'b01;
        end         
        OP_RTYPE: begin
            regDst      = 1;
            aluSrc      = 0;
            memToReg    = 0;
            regWrite    = 1;
            aluOp       = 2'b10;
        end 
    endcase
end

endmodule : ControlModule
