module Processor
import types::*;
();

// posso so perguntar variavel ? e deixar implicito que quero comparar com 1
// posso atribuir na declaracao?
// como pegar as flags dos controles e o zero da ula? clk?

// remover wires redundzntes

reg bus_type pc;

wire bus_type pc_to_four_adder;
wire bus_type four_adder_output;
wire bus_type mux_to_pc;
wire bus_type alu_result_adder_to_mux;
wire bus_type pc_to_instruction_memory;
wire bus_type instruction_memory_output;
wire bus_type sign_extend_to_shift_left;
wire bus_type sign_extend_to_mux;
wire bus_type shift_left_to_alu_result_adder;
wire bus_type regfile_read_data_1_to_alu;
wire bus_type regfile_read_data_2;
wire bus_type alu_to_data_memory; 
wire bus_type mux_to_alu;
wire bus_type alu_to_mux;
wire bus_type data_memory_to_mux;
wire bus_type mux_to_regfile_write_data;

wire [0:4] instruction_memory_to_regfile_read_1;
wire [0:4] instruction_memory_to_regfile_read_2;
wire [0:4] instruction_memory_to_mux_0;
wire [0:4] instruction_memory_to_mux_1;
wire [0:5] instruction_memory_to_alu_control;
wire [0:4] mux_to_regfile_write_reg; 
wire [0:15] instruction_memory_to_sign_extend;
wire opcode_type instruction_memory_to_control;

wire regDst;
wire aluSrc;
wire memToReg;
wire regWrite;
wire memRead;
wire memWrite;
wire branch;
wire logic [0:1] aluOp;
wire logic [0:5] funct;
wire logic [0:3] operation;

assign sign_extend_to_shift_left = { {16{instruction_memory_to_sign_extend[15]}}, instruction_memory_to_sign_extend}
assign shift_left_to_alu_result_adder = {sign_extend_to_shift_left[0:29], 2'b00}

assign instruction_memory_to_regfile_read_1 = instruction_memory_output[21:25];
assign instruction_memory_to_regfile_read_2 = instruction_memory_output[16:20];
assign instruction_memory_to_mux_0 = instruction_memory_output[16:20];
assign instruction_memory_to_mux_1 = instruction_memory_output[11:15];
assign instruction_memory_to_alu_control = instruction_memory_output[26:31];

assign mux_to_regfile_write_reg = regDst = 0 ? instruction_memory_to_mux_0 : instruction_memory_to_mux_1;
assign mux_to_alu = aluSrc = 0 ? regfile_read_data_2_to_mux : sign_extend_to_mux;
assign mux_to_regfile_write_data = memToReg = 0 ? alu_to_mux : data_memory_to_mux;
assign mux_to_pc = (branch & zero) = 0 ? four_adder_output : alu_result_adder_to_mux;

AddModule four_adder(.a(pc) .b(0x04), .s(four_adder_output));

AddModule alu_result_adder(.a(four_adder_output), .b(shift_left_to_alu_result_adder), .s(alu_result_adder_to_mux));

ALUModule alu(.a(regfile_read_data_1_to_alu), .b(mux_to_alu), .sel(operation), .s(alu_to_data_memory), .zero(?));

RegFileModule reg_file(.read_addr_1(instruction_memory_to_regfile_read_1), .read_addr_2(instruction_memory_to_regfile_read_2), .write_addr(mux_to_regfile_write_reg), .input_data(mux_to_regfile_write_data), .clk(?), .enable(regWrite), .fetched_value_1(regfile_read_data_1_to_alu), .fetched_value_2(regfile_read_data_2));

InstrMemoModule instruction_memory(.read_addr(pc_to_instruction_memory), .instruction(instruction_memory_output));

DataMemoModule data_memory(.address(alu_to_data_memory), .input_data(regfile_read_data_2), .clk(?), .enable_read(memRead), .enable_write(memWrite), .read_data(data_memory_to_mux));

ControlModule control(.op(instruction_memory_to_control), .regDst(regDst), .aluSrc(aluSrc), .memToReg(memToReg), .regWrite(regWrite), .memRead(memRead), .memWrite(memWrite), .branch(branch), .aluOp(aluOp));

ALUControlModule alu_control(.aluOp(aluOp), .funct(funct), .operation(operation));

endmodule : Processor
