import cocotb
from cocotb.triggers import ClockCycles
from cocotb.clock import Clock

class TB:
    dut = cocotb.top

    def __init__(self, cycle=2):
        cocotb.start_soon(Clock(TB.dut.clk, cycle, 'ns').start())

@cocotb.test(skip=False)
async def run(dut):
    tb = TB()

    await ClockCycles(dut.clk, 200, rising=True)

    for i in range(12):
        print(dut.data_memory.registers[4*i + 3].value,dut.data_memory.registers[4*i + 2].value,dut.data_memory.registers[4*i + 1].value,dut.data_memory.registers[4*i].value)

    assert 1 == 1


