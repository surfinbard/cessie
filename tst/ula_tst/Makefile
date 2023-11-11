# Makefile

# defaults
SIM = icarus
TOPLEVEL_LANG = verilog

VERILOG_SOURCES += ../../src/types.sv 			\
				   ../../src/arithmetic.sv 		\
				   ../../src/add.sv 			\
				   ../../src/sub.sv 			\
				   ../../src/and.sv 			\
				   ../../src/or.sv 				\
				   ../../src/slt.sv 			\
				   ../../src/nor.sv
# use VHDL_SOURCES for VHDL files
#
# Dump VCD files
ifeq ($(SIM), $(filter $(SIM), modelsim questa))
	COMPILE_ARGS += +define+_WIDTH_=32
else
	COMPILE_ARGS += -D_WIDTH_=32
endif

## Verilator traces
ifeq ($(SIM), verilator)
	EXTRA_ARGS += --trace-fst --trace-structs
endif

## Generating icarus waveform
ifeq ($(SIM), $(filter $(SIM), icarus modelsim questa))
	WAVES = 1
endif

# TOPLEVEL is the name of the toplevel module in your Verilog or VHDL file
TOPLEVEL = Aritmethic

# MODULE is the basename of the Python test file
MODULE = arithmetic_test

# include cocotb's make rules to take care of the simulator setup
include $(shell cocotb-config --makefiles)/Makefile.sim
