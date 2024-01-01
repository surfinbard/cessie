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
    assert dut.regDst.value == 1, f'Control mismatch in R-TYPE RegDst: {dut.regDst.value} != 1.'
    assert dut.aluSrc.value == 0, f'Control mismatch in R-TYPE ALUSrc: {dut.aluSrc.value} != 0.'
    assert dut.memToReg.value == 0, f'Control mismatch in R-TYPE MemtoReg: {dut.memToReg.value} != 0.'
    assert dut.regWrite.value == 1, f'Control mismatch in R-TYPE RegWrite: {dut.regWrite.value} != 1.'
    assert dut.memRead.value == 0, f'Control mismatch in R-TYPE MemRead: {dut.memRead.value} != 0.'
    assert dut.memWrite.value == 0, f'Control mismatch in R-TYPE MemWrite: {dut.memWrite.value} != 0.'
    assert dut.branch.value == 0, f'Control mismatch in R-TYPE Branch: {dut.branch.value} != 0.'
    assert dut.aluOp.value == 2, f'Control mismatch in R-TYPE ALUOp: {dut.aluOp.value} != 10.'

    # BEQ
    tb.dut.op.value = 4
    await Timer(10, units='ns')
    # assert (not dut.regDst.value.is_resolvable), f'Control mismatch in BEQ RegDst: {dut.regDst.value} != x.'
    assert dut.aluSrc.value == 0, f'Control mismatch in BEQ ALUSrc: {dut.aluSrc.value} != 0.'
    # assert (not dut.memToReg.value.is_resolvable), f'Control mismatch in BEQ MemtoReg: {dut.memToReg.value} != x.'
    assert dut.regWrite.value == 0, f'Control mismatch in BEQ RegWrite: {dut.regWrite.value} != 0.'
    assert dut.memRead.value == 0, f'Control mismatch in BEQ MemRead: {dut.memRead.value} != 0.'
    assert dut.memWrite.value == 0, f'Control mismatch in BEQ MemWrite: {dut.memWrite.value} != 0.'
    assert dut.branch.value == 1, f'Control mismatch in BEQ Branch: {dut.branch.value} != 1.'
    assert dut.aluOp.value == 1, f'Control mismatch in BEQ ALUOp: {dut.aluOp.value} != 01'

    # LW
    tb.dut.op.value = 35
    await Timer(10, units='ns')
    assert dut.regDst.value == 0, f'Control mismatch in LW RegDst: {dut.regDst.value} != 0.'
    assert dut.aluSrc.value == 1, f'Control mismatch in LW ALUSrc: {dut.aluSrc.value} != 1.'
    assert dut.memToReg.value == 1, f'Control mismatch in LW MemtoReg: {dut.memToReg.value} != 1.'
    assert dut.regWrite.value == 1, f'Control mismatch in LW RegWrite: {dut.regWrite.value} != 1.'
    assert dut.memRead.value == 1, f'Control mismatch in LW MemRead: {dut.memRead.value} != 1.'
    assert dut.memWrite.value == 0, f'Control mismatch in LW MemWrite: {dut.memWrite.value} != 0.'
    assert dut.branch.value == 0, f'Control mismatch in LW Branch: {dut.branch.value} != 0.'
    assert dut.aluOp.value == 0, f'Control mismatch in LW ALUOp: {dut.aluOp.value} != 00.'

    # SW
    tb.dut.op.value = 43
    await Timer(10, units='ns')
    # assert (not dut.regDst.value.is_resolvable), f'Control mismatch in SW RegDst: {dut.regDst.value} != x.'
    assert dut.aluSrc.value == 1, f'Control mismatch in SW ALUSrc: {dut.aluSrc.value} != 1.'
    # assert (not dut.memToReg.value.is_resolvable), f'Control mismatch in SW MemtoReg: {dut.memToReg.value} != x.'
    assert dut.regWrite.value == 0, f'Control mismatch in SW RegWrite: {dut.regWrite.value} != 0.'
    assert dut.memRead.value == 0, f'Control mismatch in SW MemRead: {dut.memRead.value} != 0.'
    assert dut.memWrite.value == 1, f'Control mismatch in SW MemWrite: {dut.memWrite.value} != 1.'
    assert dut.branch.value == 0, f'Control mismatch in SW Branch: {dut.branch.value} != 0.'
    assert dut.aluOp.value == 0, f'Control mismatch in SW ALUOp: {dut.aluOp.value} != 00.'

