import cocotb
from cocotb.triggers import Timer
class TB:
    dut = cocotb.top

###############################################################
    
@cocotb.test(skip=False)
async def control(dut):
    tb = TB()
   
    # R-type
    tb.dut.op.value = 0
    await Timer(10, units='ns')
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
    await Timer(10, units='ns')
    # assert (not dut.regDst.value.is_resolvable), f'Control mismatch in RegDst: {dut.regDst.value} != x.'
    assert dut.aluSrc.value == 0, f'Control mismatch in ALUSrc: {dut.aluSrc.value} != 0.'
    # assert (not dut.memToReg.value.is_resolvable), f'Control mismatch in MemtoReg: {dut.memToReg.value} != x.'
    assert dut.regWrite.value == 0, f'Control mismatch in RegWrite: {dut.regWrite.value} != 0.'
    assert dut.memRead.value == 0, f'Control mismatch in MemRead: {dut.memRead.value} != 0.'
    assert dut.memWrite.value == 0, f'Control mismatch in MemWrite: {dut.memWrite.value} != 0.'
    assert dut.branch.value == 1, f'Control mismatch in Branch: {dut.branch.value} != 1.'
    assert dut.aluOp.value == 1, f'Control mismatch in ALUOp: {dut.aluOp.value} != 01'

    # LW
    tb.dut.op.value = 35
    await Timer(10, units='ns')
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
    await Timer(10, units='ns')
    # assert (not dut.regDst.value.is_resolvable), f'Control mismatch in RegDst: {dut.regDst.value} != x.'
    assert dut.aluSrc.value == 1, f'Control mismatch in ALUSrc: {dut.aluSrc.value} != 1.'
    # assert (not dut.memToReg.value.is_resolvable), f'Control mismatch in MemtoReg: {dut.memToReg.value} != x.'
    assert dut.regWrite.value == 0, f'Control mismatch in RegWrite: {dut.regWrite.value} != 0.'
    assert dut.memRead.value == 0, f'Control mismatch in MemRead: {dut.memRead.value} != 0.'
    assert dut.memWrite.value == 1, f'Control mismatch in MemWrite: {dut.memWrite.value} != 1.'
    assert dut.branch.value == 0, f'Control mismatch in Branch: {dut.branch.value} != 0.'
    assert dut.aluOp.value == 0, f'Control mismatch in ALUOp: {dut.aluOp.value} != 00.'

