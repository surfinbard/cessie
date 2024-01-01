import cocotb
from cocotb.triggers import Timer
class TB:
    dut = cocotb.top

    def __init__(self):
        for i in range(32):
            TB.dut.registers[i].value = 0

    async def config(self):
        for i in range(32):
            TB.dut.registers[i].value = i    
            await Timer(10, units='ns')

###############################################################
    
@cocotb.test(skip=False)
async def instr_read(dut):
    tb = TB()
    await tb.config()
   
    for i in range(32):
        assert dut.registers[i].value == i, f'Control mismatch in instr_read: {dut.registers[i].value} != {i}.'

