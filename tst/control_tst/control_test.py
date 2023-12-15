import cocotb
from cocotb.triggers import RisingEdge
from cocotb.clock import Clock

class TB:
    dut = cocotb.top

    def __init__(self, cycle=2):
        cocotb.start_soon(Clock(TB.dut.clk, cycle, 'ns').start())

###############################################################
    
@cocotb.test(skip=False)
async def control(dut):
    tb = TB()
   
    # R-type
    tb.dut.op.value = 0
    await RisingEdge(tb.dut.clk)
    assert dut.regDst.value == 1, f'Control mismatch in RegDst: {dut.regDst.value} != 1.'
    assert dut.aluSrc.value == 0, f'Control mismatch in ALUSrc: {dut.aluSrc.value} != 0.'
    assert dut.memToReg.value == 0, f'Control mismatch in MemtoReg: {dut.memToReg.value} != 0.'
    assert dut.regWrite.value == 1, f'Control mismatch in RegWrite: {dut.regWrite.value} != 1.'
    assert dut.memRead.value == 0, f'Control mismatch in MemRead: {dut.memRead.value} != 0.'
    assert dut.memWrite.value == 0, f'Control mismatch in MemWrite: {dut.memWrite.value} != 0.'
    assert dut.branch.value == 0, f'Control mismatch in Branch: {dut.branch.value} != 0.'
    assert dut.aluOp.value == 2, f'Control mismatch in ALUOp: {dut.aluOp.value} != 10.'

    # BEQ
    tb.dut.op.value = 4
    await RisingEdge(tb.dut.clk)
    assert dut.regDst.value == x, f'Control mismatch in RegDst: {dut.regDst.value} != x.'
    assert dut.aluSrc.value == 0, f'Control mismatch in ALUSrc: {dut.aluSrc.value} != 0.'
    assert dut.memToReg.value == x, f'Control mismatch in MemtoReg: {dut.memToReg.value} != x.'
    assert dut.regWrite.value == 0, f'Control mismatch in RegWrite: {dut.regWrite.value} != 0.'
    assert dut.memRead.value == 0, f'Control mismatch in MemRead: {dut.memRead.value} != 0.'
    assert dut.memWrite.value == 0, f'Control mismatch in MemWrite: {dut.memWrite.value} != 0.'
    assert dut.branch.value == 1, f'Control mismatch in Branch: {dut.branch.value} != 1.'
    assert dut.aluOp.value == 1, f'Control mismatch in ALUOp: {dut.aluOp.value} != 01'

    # LW
    tb.dut.op.value = 35
    await RisingEdge(tb.dut.c1k)
    assert dut.regDst.value == 0, f'Control mismatch in RegDst: {dut.regDst.value} != 0.'
    assert dut.aluSrc.value == 1, f'Control mismatch in ALUSrc: {dut.aluSrc.value} != 1.'
    assert dut.memToReg.value == 1, f'Control mismatch in MemtoReg: {dut.memToReg.value} != 1.'
    assert dut.regWrite.value == 1, f'Control mismatch in RegWrite: {dut.regWrite.value} != 1.'
    assert dut.memRead.value == 1, f'Control mismatch in MemRead: {dut.memRead.value} != 1.'
    assert dut.memWrite.value == 0, f'Control mismatch in MemWrite: {dut.memWrite.value} != 0.'
    assert dut.branch.value == 0, f'Control mismatch in Branch: {dut.branch.value} != 0.'
    assert dut.aluOp.value == 0, f'Control mismatch in ALUOp: {dut.aluOp.value} != 00.'

    # SW
    tb.dut.op.value = 43
    await RisingEdge(tb.dut.clk)
    assert dut.regDst.value == x, f'Control mismatch in RegDst: {dut.regDst.value} != x.'
    assert dut.aluSrc.value == 1, f'Control mismatch in ALUSrc: {dut.aluSrc.value} != 1.'
    assert dut.memToReg.value == x, f'Control mismatch in MemtoReg: {dut.memToReg.value} != x.'
    assert dut.regWrite.value == 0, f'Control mismatch in RegWrite: {dut.regWrite.value} != 0.'
    assert dut.memRead.value == 0, f'Control mismatch in MemRead: {dut.memRead.value} != 0.'
    assert dut.memWrite.value == 1, f'Control mismatch in MemWrite: {dut.memWrite.value} != 1.'
    assert dut.branch.value == 0, f'Control mismatch in Branch: {dut.branch.value} != 0.'
    assert dut.aluOp.value == 0, f'Control mismatch in ALUOp: {dut.aluOp.value} != 00.'


###############################################################
    
@cocotb.test(skip=False)
async def alu_control(dut):
    tb = TB()

    # ADD
    tb.dut.funct.value = 0
    await RisingEdge(tb.dut.clk)
    assert dut.s.value == 2, f'ALU Control mismatch: {dut.s.value} != 0010.'

    # SUB
    tb.dut.funct.value = 2
    await RisingEdge(tb.dut.clk)
    assert dut.s.value == 6, f'ALU Control mismatch: {dut.s.value} != 0110.'

    # AND
    tb.dut.funct.value = 4
    await RisingEdge(tb.dut.clk)
    assert dut.s.value == 0, f'ALU Control mismatch: {dut.s.value} != 0000.'

    # OR
    tb.dut.funct.value = 5
    await RisingEdge(tb.dut.clk)
    assert dut.s.value == 1, f'ALU Control mismatch: {dut.s.value} != 0001.'

    # SLT
    tb.dut.funct.value = 10
    await RisingEdge(tb.dut.clk)
    assert dut.s.value == 7, f'ALU Control mismatch: {dut.s.value} != "SLT".'
