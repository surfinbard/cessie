//`default_nettype none
`ifndef _WIDTH_
`define _WIDTH_ 32
`endif

package types;
  parameter int WIDTH = `_WIDTH_;

  typedef logic [WIDTH-1:0] bus_type;

  typedef enum logic [3:0] {
    ALU_AND  = 4'b0000,
    ALU_OR   = 4'b0001,
    ALU_ADD  = 4'b0010,
    ALU_SUB  = 4'b0110,
    ALU_SLT  = 4'b0111,
    ALU_NOR  = 4'b1100,
    ALU_SLTU = 4'b1101
  } alu_oper_type;

  // Taken from https://student.cs.uwaterloo.ca/~isg/res/mips/opcodes
  
  typedef enum logic [5:0] {
    OP_RTYPE    = 6'b000000,
    OP_ADDI	    = 6'b001000,	//ArithLogI
    //OP_ADDIU	  = 6'b001001,	//ArithLogI
    OP_ANDI	    = 6'b001100,	//ArithLogI
    OP_ORI	    = 6'b001101,	//ArithLogI
    OP_XORI	    = 6'b001110,	//ArithLogI
    OP_LHI	    = 6'b011001,	//LoadI
    OP_LLO	    = 6'b011000,	//LoadI
    OP_SLTI	    = 6'b001010,	//ArithLogI
    //OP_SLTIU	  = 6'b001001,	//ArithLogI
    OP_BEQ	    = 6'b000100,	//Branch	
    OP_BGTZ	    = 6'b000111,	//BranchZ
    OP_BLEZ	    = 6'b000110,	//BranchZ
    OP_BNE	    = 6'b000101,	//Branch	
    OP_J	      = 6'b000010,	//Jump
    OP_JAL	    = 6'b000011,	//Jump
    OP_LB	      = 6'b100000,	//LoadStore
    OP_LBU	    = 6'b100100,	//LoadStore
    OP_LH	      = 6'b100001,	//LoadStore
    OP_LHU	    = 6'b100101,	//LoadStore
    OP_LW	      = 6'b100011,	//LoadStore
    OP_SB	      = 6'b101000,	//LoadStore
    OP_SH	      = 6'b101001,	//LoadStore
    OP_SW	      = 6'b101011,	//LoadStore
    OP_TRAP	    = 6'b011010
  } opcode_type;

    typedef enum logic [5:0] {
    FUNC_ADD	  = 6'b100000,	//ArithLog
    FUNC_ADDU	  = 6'b100001,	//ArithLog
    FUNC_AND	  = 6'b100100,	//ArithLog
    FUNC_DIV	  = 6'b011010,	//DivMult
    FUNC_DIVU	  = 6'b011011,	//DivMult
    FUNC_MULT	  = 6'b011000,	//DivMult
    FUNC_MULTU	= 6'b011001,	//DivMult
    FUNC_NOR	  = 6'b100111,	//ArithLog
    FUNC_OR	    = 6'b100101,	//ArithLog
    FUNC_SLL	  = 6'b000000,	//Shift	
    FUNC_SLLV	  = 6'b000100,	//ShiftV
    FUNC_SRA	  = 6'b000011,	//Shift
    FUNC_SRAV	  = 6'b000111,	//ShiftV
    FUNC_SRL	  = 6'b000010,	//Shift	
    FUNC_SRLV	  = 6'b000110,	//ShiftV
    FUNC_SUB	  = 6'b100010,	//ArithLog
    FUNC_SUBU	  = 6'b100011,	//ArithLog
    FUNC_XOR	  = 6'b100110,	//ArithLog
    FUNC_SLT	  = 6'b101010,	//ArithLog
    FUNC_SLTU	  = 6'b101001,	//ArithLog
    FUNC_JALR	  = 6'b001001,	//JumpR
    FUNC_JR	    = 6'b001000,	//JumpR	
    FUNC_MFHI	  = 6'b010000,	//MoveFrom
    FUNC_MFLO	  = 6'b010010,	//MoveFrom
    FUNC_MTHI	  = 6'b010001,	//MoveTo	
    FUNC_MTLO	  = 6'b010011 	//MoveTo
    } funct_type;
    
endpackage