import cocotb
from cocotb.triggers import Timer
import random

class TB:
    dut = cocotb.top

###############################################################
    
@cocotb.test(skip=False)
async def adder(dut):
    tb = TB()

    # Forçando o controle como somador
    tb.dut.aluOp.value = 0
    await Timer(10, units='ns')

    for i in range(10):    
        tb.dut.funct.value = random.randint(0, 63)
        await Timer(10, units='ns')
        assert dut.operation.value == 2, f'ALU Control mismatch: {dut.operation.value} != 0010.'

###############################################################
    
@cocotb.test(skip=False)
async def subtractor(dut):
    tb = TB()

    # Forçando o controle como subtrator 
    tb.dut.aluOp.value = 1
    await Timer(10, units='ns')

    for i in range(10):    
        tb.dut.funct.value = random.randint(0, 63)
        assert dut.operation.value == 6, f'ALU Control mismatch: {dut.operation.value} != 0110.'

###############################################################
    
@cocotb.test(skip=False)
async def alu(dut):
    tb = TB()

    # ADD
    tb.dut.funct.value = 0x20
    tb.dut.aluOp.value = 2
    await Timer(10, units='ns')
    assert dut.operation.value == 2, f'ALU Control mismatch: {dut.operation.value} != 0010.'

    # SUB
    tb.dut.funct.value = 0x22
    tb.dut.aluOp.value = 2
    await Timer(10, units='ns')
    assert dut.operation.value == 6, f'ALU Control mismatch: {dut.operation.value} != 0110.'

    # AND
    tb.dut.funct.value = 0x24
    tb.dut.aluOp.value = 2
    await Timer(10, units='ns')
    assert dut.operation.value == 0, f'ALU Control mismatch: {dut.operation.value} != 0000.'

    # OR
    tb.dut.funct.value = 0x25
    tb.dut.aluOp.value = 2
    await Timer(10, units='ns')
    assert dut.operation.value == 1, f'ALU Control mismatch: {dut.operation.value} != 0001.'

    # SLT
    tb.dut.funct.value = 0x2A
    tb.dut.aluOp.value = 2
    await Timer(10, units='ns')
    assert dut.operation.value == 7, f'ALU Control mismatch: {dut.operation.value} != "SLT".'

###############################################################
    