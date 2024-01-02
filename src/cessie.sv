module Cessie
import types::*;
();

//make sl2, 4 muxes, 1 sign extend

reg bus_type pc;
wire bus_type pc_to_four_adder;
wire bus_type four_adder_to_alu_result_adder;
wire bus_type four_adder_to_mux;
wire bus_type mux_to_pc;
wire bus_type alu_result_adder_to_mux;
wire bus_type pc_to_instruction_memory;
wire opcode_type instruction_memory_to_control;
wire [0:5] instruction_memory_to_regfile_read_1;
wire [0:5] instruction_memory_to_regfile_read_2;
wire [0:5] instruction_memory_to_mux_0;
wire [0:5] instruction_memory_to_mux_1;
wire [0:5] mux_to_regfile_write_reg; 
wire [0:5] instruction_memory_to_alu_control;
wire [0:15] instruction_memory_to_sign_extend;
wire bus_type sign_extend_to_shift_left;
wire bus_type shift_left_to_alu_result_adder;
wire bus_type regfile_read_data_1_to_alu;
wire bus_type regfile_read_data_2_to_mux;
wire bus_type regfile_read_data_2_to_data_memory;
wire [0:5] alu_to_data_memory; 
wire bus_type mux_to_alu;
wire bus_type alu_to_mux;
wire bus_type data_memory_to_mux;
wire bus_type mux_to_regfile_write_data;

AddModule four_adder(.a() .b(), .s());

AddModule alu_result_adder(.a(), .b(), .s());

ALUModule alu(.a(), .b(), .sel(), .s(), .zero());

RegFileModule reg_file(.read_addr_1(), .read_addr_2(), .write_addr(), .input_data(), .clk(), .enable(), .fetched_value_1(), .fetched_value_2());

InstrMemoModule instruction_memory(.read_addr(), .instruction());

DataMemoModule data_memory(.address(), .input_data(), .clk(), .enable_read(), .enable_write(), .read_data());

ControlModule control(.op(), .regDst(), .aluSrc(), .memToReg(), .regWrite(), .memRead(), .memWrite(), .branch(), .aluOp());

ALUControlModule alu_control(.aluOp(), .funct(), .operation());

endmodule : Cessie
