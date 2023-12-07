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
        TB.dut.data.value = int.from_bytes(random.randbytes(4), sys.byteorder)

    def config(self):
        TB.dut.read_addr_1.value = 0x0
        TB.dut.read_addr_2.value = 0x0
        TB.dut.enable.value = 0
        TB.dut.data.value = 0

    @classmethod
    def found_dont_care(str):
        for char in str:
            if char == 'x':
                return True
        return False

@cocotb.test(skip=True)
async def reset(dut):
    tb = TB()
    tb.config()

    for i in range(32):
        dut.read_addr_1.value = i
        await Timer(1, units='ns')
        assert dut.fetched_value_1.value == 0x0, f'RST mismatch: s: {dut.fetched_value_1.value} != 0.'

###############################################################
    
@cocotb.test(skip=True)
async def write_enable_off(dut):
    tb = TB()

    for i in range(32):
        tb.config()
        tb.randomize_input_value(i)
        await RisingEdge(TB.dut.clk)

        for j in range(1, 32):
            dut.read_addr_1.value = j
            await Timer(1, units='ns')
            assert dut.fetched_value_1.value == 0x0, f'Write mismatch: s: {dut.fetched_value_1.value} != 0.'


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
        
        assert dut.fetched_value_1.value == dut.data.value, f'Write mismatch: s: {dut.fetched_value_1.value} != {dut.data.value}.'

###############################################################
    
@cocotb.test(skip=True)
async def write_enable_on_reset_on(dut):
    tb = TB()

    for i in range(32):
        tb.config()
        dut.enable.value = 1
        tb.randomize_input_value(i)
        await RisingEdge(TB.dut.clk)

        for j in range(1, 32):
            dut.read_addr_1.value = j
            await Timer(1, units='ns')
            if (j == i):
                assert dut.fetched_value_1.value == dut.data.value, f'Write mismatch: s: {dut.fetched_value_1.value} != {dut.data.value}.'
            else:
                if dut.fetched_value_1.value.is_resolvable:
                    assert dut.fetched_value_1.value == 0x0, f'Write mismatch: s: {dut.fetched_value_1.value} != 0.'


###############################################################
    
@cocotb.test(skip=True)
async def write_zero(dut):
    tb = TB()

    for i in range(32):
        tb.config()
        dut.enable.value = 1
        tb.randomize_input_value(i)
        await RisingEdge(TB.dut.clk)

        for j in range(1, 32):
            dut.read_addr_1.value = j
            await Timer(1, units='ns')
            if (j == i):
                assert dut.fetched_value_1.value == {dut.data.value}, f'Write mismatch: s: {dut.fetched_value_1.value} != {dut.data.value}.'
            else:
                assert dut.fetched_value_1.value == 0x0, f'Write mismatch: s: {dut.fetched_value_1.value} != 0.'

    #tentei chamar config e reset_all no init mas  'TB.reset_all' was never awaited. existe algum jeito de nao precisarr chamar tud em todo teste?

    #a leitura e assincrona. use um timer menor que o clk.
    # todo testes slt, teste zero