import cocotb
from cocotb.triggers import RisingEdge, Timer
from cocotb.clock import Clock
class TB:
    dut = cocotb.top

    def __init__(self, cycle=1):
        cocotb.start_soon(Clock(TB.dut.clk, cycle, 'ns').start())
        TB.dut.enable_write.value = 0
        TB.dut.enable_read.value = 0

    async def config(self):
        TB.dut.enable_write.value = 1
        for i in range(32):
            TB.dut.address.value = i
            TB.dut.input_data.value = 0
            await RisingEdge(TB.dut.clk)
        TB.dut.enable_write.value = 0
        TB.dut.enable_read.value = 0

    async def set_in_increments(self):
        TB.dut.enable_write.value = 1
        for i in range(32):
            TB.dut.address.value = i
            TB.dut.input_data.value = i
            await RisingEdge(TB.dut.clk)
        TB.dut.enable_write.value = 0

###############################################################
    
@cocotb.test(skip=False)
async def read_enable_off(dut):
    tb = TB()
    await tb.set_in_increments()

    for i in range(32):
        assert dut.read_data.value == 0, f'Control mismatch in read_enable_off: {dut.read_data.value} != 0.'

@cocotb.test(skip=False)
async def read_enable_on(dut):
    tb = TB()
    await tb.set_in_increments()

    dut.enable_read.value = 1
    for i in range(32):
        dut.address.value = i
        await RisingEdge(TB.dut.clk)
        
        assert dut.read_data.value == i, f'Control mismatch in read_enable_on: {dut.read_data.value} != {i}.'

@cocotb.test(skip=False)
async def write_enable_off(dut):
    tb = TB()
    await tb.config()

    dut.enable_write.value = 0
    for i in range(32):
        dut.address.value = i
        dut.input_data.value = i
        await RisingEdge(TB.dut.clk)

    dut.enable_read.value = 1
    for i in range(32):
        dut.address.value = i
        await RisingEdge(TB.dut.clk)
        
        assert dut.read_data.value == 0, f'Control mismatch in write_enable_off: {dut.read_data.value} != 0.'

@cocotb.test(skip=False)
async def write_enable_on(dut):
    tb = TB()
    await tb.config()

    dut.enable_write.value = 1
    for i in range(32):
        dut.address.value = i
        dut.input_data.value = i
        await RisingEdge(TB.dut.clk)

    dut.enable_write.value = 0
    dut.enable_read.value = 1
    for i in range(32):
        dut.address.value = i
        await RisingEdge(TB.dut.clk)    
        
        assert dut.read_data.value == i, f'Control mismatch in write_enable_on: {dut.read_data.value} != {i}.'
