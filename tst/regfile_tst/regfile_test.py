import sys
import random
import cocotb
from cocotb.triggers import RisingEdge, Timer
from cocotb.clock import Clock

class TB:
    dut = cocotb.top

    def __init__(self, cycle=2):
        cocotb.start_soon(Clock(TB.dut.clk, cycle, 'ns').start())

    def randomize_input_value(self, addr):
        TB.dut.write_addr.value = addr
        TB.dut.input_data.value = int.from_bytes(random.randbytes(4), sys.byteorder)

    def config(self):
        TB.dut.read_addr_1.value = 0x0
        TB.dut.read_addr_2.value = 0x0
        TB.dut.enable.value = 0
        TB.dut.input_data.value = 0

    async def rst_all(self):
        TB.dut.enable.value = 1        
        for i in range(1, 32):
            TB.dut.write_addr.value = i
            TB.dut.input_data.value = 0
            await RisingEdge(TB.dut.clk)
        TB.dut.enable.value = 0

    @classmethod
    def found_dont_care(str):
        for char in str:
            if char == 'x':
                return True
        return False

@cocotb.test(skip=False)
async def reset(dut):
    tb = TB()

    for i in range (1, 32):
        tb.config()
        dut.enable.value = 1
        tb.dut.write_addr.value = i
        tb.dut.input_data.value = 0
        await RisingEdge(TB.dut.clk)

        dut.read_addr_1.value = i
        await Timer(10, units='ns')
        
        assert dut.fetched_value_1.value == 0, f'Write mismatch: {dut.fetched_value_1.value} != 0.'

###############################################################
    
@cocotb.test(skip=False)
async def write_enable_off(dut):
    tb = TB()

    tb.dut.enable.value = 1
    for i in range(1, 32):
        tb.dut.write_addr.value = i
        tb.dut.input_data.value = i
        await RisingEdge(tb.dut.clk)
    tb.dut.enable.value = 0

    for i in range(1, 32):
        tb.config()
        # with enable off, try to write anything (else), then check if values changed
        tb.randomize_input_value(i)
        await RisingEdge(TB.dut.clk)

        for j in range(1, 32):
            dut.read_addr_1.value = j
            await Timer(1, units='ns')
            assert dut.fetched_value_1.value == j, f'Write mismatch: {dut.fetched_value_1.value} != j.'
                
###############################################################
    
@cocotb.test(skip=False)
async def write_enable_on_reset_off(dut):
    tb = TB()

    for i in range (1, 32):
        tb.config()
        dut.enable.value = 1
        tb.randomize_input_value(i)
        await RisingEdge(TB.dut.clk)

        dut.read_addr_1.value = i
        await Timer(10, units='ns')
        
        assert dut.fetched_value_1.value == dut.input_data.value, f'Write mismatch: {dut.fetched_value_1.value} != {dut.input_data.value}.'

###############################################################
    
@cocotb.test(skip=False)
async def write_enable_on_reset_on(dut):
    tb = TB()

    for i in range(1, 32):
        tb.config()
        await tb.rst_all()
        dut.enable.value = 1
        tb.randomize_input_value(i)
        await RisingEdge(TB.dut.clk)

        for j in range(1, 32):
            dut.read_addr_1.value = j
            await Timer(1, units='ns')
            if (j == i):
                assert dut.fetched_value_1.value == dut.input_data.value, f'Write mismatch: {dut.fetched_value_1.value} != {dut.input_data.value}.'
            else:
                assert dut.fetched_value_1.value == 0x0, f'Write mismatch: {dut.fetched_value_1.value} != 0.'

###############################################################
    
@cocotb.test(skip=False)
async def write_zero(dut):
    tb = TB()

    tb.config()
    dut.enable.value = 1
    tb.randomize_input_value(0)
    await RisingEdge(TB.dut.clk)

    dut.read_addr_1.value = 0
    await Timer(1, units='ns')
    assert dut.fetched_value_1.value == 0, f'Write mismatch: {dut.fetched_value_1.value} != 0.'

###############################################################
    
@cocotb.test(skip=False)
async def read_from_both(dut):
    tb = TB()

    tb.dut.enable.value = 1
    for i in range(1, 32):
        tb.dut.write_addr.value = i
        tb.dut.input_data.value = i
        await RisingEdge(tb.dut.clk)
    tb.dut.enable.value = 0

    for i in range(1, 32):
        tb.config()
        # with enable off, try to write anything (else), then check if values changed
        tb.randomize_input_value(i)
        await RisingEdge(TB.dut.clk)

        for j in range(1, 32):
            dut.read_addr_1.value = j
            dut.read_addr_2.value = 32 - j
            await Timer(1, units='ns')
            assert dut.fetched_value_1.value == j, f'Write mismatch: {dut.fetched_value_1.value} != j.'
            assert dut.fetched_value_2.value == 32 - j, f'Write mismatch: {dut.fetched_value_2.value} != {32 - j}.'