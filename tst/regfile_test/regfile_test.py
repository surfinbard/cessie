import sys
import random
import cocotb
from cocotb.triggers import RisingEdge, Timer
from cocotb.clock import Clock

class TB:
    dut = cocotb.top

    def __init__(self, cycle=2):
        cocotb.start_soon(Clock(TB.dut.clk, cycle, 'ns').start())
        self.config()
        self.reset_all()

    async def randomize_input_value(self, addr):
        TB.dut.write_addr.value = addr
        await Timer(1, units='ns')
        TB.dut.data.value = int.from_bytes(random.randbytes(4), sys.byteorder)

    async def reset_all(self):
        for i in range(32):
            TB.dut.registers[i].value = 0x0
        await RisingEdge(TB.dut.clk)

    def config(self):
        TB.dut.read_addr_1.value = 0x0
        TB.dut.read_addr_2.value = 0x0
        TB.dut.enable.value = 0
        TB.dut.data.value = 0

@cocotb.test(skip=False)
async def reset(dut):
    tb = TB()
    tb.config()
    await tb.reset_all()

    for i in range(32):
        dut.read_addr_1 = i
        await Timer(1, units='ns')
        assert dut.fetched_value_1 == 0x0, f'RST mismatch: s: {dut.fetched_value_1} != 0.'

###############################################################
    
@cocotb.test(skip=False)
async def write_once(dut):
    tb = TB(TB.andmod)

    for i in range(32):
        await tb.randomize_input_value()

        
    await RisingEdge(dut.clk)
    assert dut.s.value == 0x0000_0000, f'AND mismatch: s: {dut.s.value} != {dut.a.value}.'


###############################################################
    
    #pq timer e nao clk?
    #tentei chamar config e reset_all no init mas  'TB.reset_all' was never awaited. existe algum jeito de nao precisarr chamar tud em todo teste?
    # como esta funcionando sem enable?