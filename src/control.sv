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
                        branchBeq,
                        branchBne,
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
    branchBeq   = 0;
    branchBne   = 0;
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
            branchBeq   = 1;
            aluOp       = 2'b01;
        end    
        OP_BNE: begin
            aluSrc      = 0;
            branchBne   = 1;
            aluOp       = 2'b01;
        end     
        OP_RTYPE: begin
            regDst      = 1;
            aluSrc      = 0;
            memToReg    = 0;
            regWrite    = 1;
            aluOp       = 2'b10;
        end 
        OP_ADDI: begin
            aluSrc      = 1;
            regDst      = 0;
            memToReg    = 0;
            regWrite    = 1;
            aluOp       = 2'b00;
        end
        // SLTI
        // XOR
        // XORI
        // SLL
        // SRL
        // JAL
        // JR

        //            OP_RTYPE    = 6'b000000,
        //            OP_ADDI	    = 6'b001000,	//ArithLogI
        //            //OP_ADDIU	  = 6'b001001,	//ArithLogI
        //            OP_ANDI	    = 6'b001100,	//ArithLogI
        //            OP_ORI	    = 6'b001101,	//ArithLogI
        //            OP_XORI	    = 6'b001110,	//ArithLogI
        //            OP_LHI	    = 6'b011001,	//LoadI
        //            OP_LLO	    = 6'b011000,	//LoadI
        //            OP_SLTI	    = 6'b001010,	//ArithLogI
        //            //OP_SLTIU	  = 6'b001001,	//ArithLogI
        //            OP_BEQ	    = 6'b000100,	//Branch	
        //            OP_BGTZ	    = 6'b000111,	//BranchZ
        //            OP_BLEZ	    = 6'b000110,	//BranchZ
        //            OP_BNE	    = 6'b000101,	//Branch	
        //            OP_J	      = 6'b000010,	//Jump
        //            OP_JAL	    = 6'b000011,	//Jump
        //            OP_LB	      = 6'b100000,	//LoadStore
        //            OP_LBU	    = 6'b100100,	//LoadStore
        //            OP_LH	      = 6'b100001,	//LoadStore
        //            OP_LHU	    = 6'b100101,	//LoadStore
        //            OP_LW	      = 6'b100011,	//LoadStore
        //            OP_SB	      = 6'b101000,	//LoadStore
        //            OP_SH	      = 6'b101001,	//LoadStore
        //            OP_SW	      = 6'b101011,	//LoadStore
        //            OP_TRAP	    = 6'b011010

        precisa mexer na ula: 
        xor, 


endmodule : ControlModule
