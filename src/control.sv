module ControlModule
  import types::*;
(
    input  opcode       op,
    output logic        regDst,
                        aluSrc,
                        memToReg,
                        regWrite,
                        memRead,
                        memWrite,
                        branch,
    output logic [0:1]  aluOp            
);

always_comb begin

    regDst      = 0;
    aluSrc      = x;
    memToReg    = x;
    regWrite    = 0;
    memRead     = 0;
    memWrite    = 0;
    branch      = 0;
    aluOp       = 2'bxx;

    case(op)
        OP_LW: begin
            aluSrc      = 1;
            memToReg    = 1;
            regWrite    = 1;
            memRead     = 1;
            aluOp       = 2'b00;
        end     
        OP_SW: begin
            regDst      = x;
            aluSrc      = 1;
            memWrite    = 1;
            aluOp       = 2'b00;
        end      
        OP_BEQ: begin
            regDst      = x;
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
