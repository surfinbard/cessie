module Processor
import types::*;
(
    input clk
);

bus_type pc;

bus_type pc_to_four_adder;
bus_type four_adder_output;
bus_type mux_to_pc;
bus_type alu_result_adder_to_mux;
bus_type instruction_memory_output;
bus_type sign_extend_output;
bus_type shift_left_to_alu_result_adder;
bus_type regfile_read_data_1_to_alu;
bus_type regfile_read_data_2;
bus_type alu_output; 
bus_type mux_to_alu;
bus_type data_memory_to_mux;
bus_type mux_to_regfile_write_data;

bus_type mux_to_mux;
bus_type jump_address;
wire [25:0] instruction_memory_to_shift_left_2;

wire [4:0] instruction_memory_to_regfile_read_1;
wire [4:0] instruction_memory_to_regfile_read_2;
wire [4:0] instruction_memory_to_mux_0;
wire [4:0] instruction_memory_to_mux_1;
wire [5:0] instruction_memory_to_alu_control;
wire [4:0] mux_to_regfile_write_reg; 
wire [15:0] instruction_memory_to_sign_extend;
opcode_type instruction_memory_to_control;

wire jump;
wire zero;
wire regDst;
wire aluSrc;
wire memToReg;
wire regWrite;
wire memRead;
wire memWrite;
wire branch;
wire [1:0] aluOp;
wire [5:0] funct;
wire [3:0] operation;

assign instruction_memory_to_shift_left_2 = instruction_memory_output[25:0];
assign jump_address = {four_adder_output[31:28], instruction_memory_to_shift_left_2, 2'b00};

assign instruction_memory_to_regfile_read_1 = instruction_memory_output[25:21];
assign instruction_memory_to_regfile_read_2 = instruction_memory_output[20:16];
assign instruction_memory_to_mux_0 = instruction_memory_output[20:16];
assign instruction_memory_to_mux_1 = instruction_memory_output[15:11];
assign instruction_memory_to_sign_extend = instruction_memory_output[15:0];
assign instruction_memory_to_alu_control = instruction_memory_output[5:0];
assign instruction_memory_to_control = opcode_type'(instruction_memory_output[31:26]);

assign sign_extend_output = { {16{instruction_memory_to_sign_extend[15]}}, instruction_memory_to_sign_extend};
assign shift_left_to_alu_result_adder = {sign_extend_output[29:0], 2'b00};

assign mux_to_regfile_write_reg = regDst ? instruction_memory_to_mux_1 : instruction_memory_to_mux_0;
assign mux_to_alu = aluSrc ? sign_extend_output : regfile_read_data_2;
assign mux_to_regfile_write_data = memToReg ? data_memory_to_mux : alu_output;
assign mux_to_mux = (branch & zero) ? alu_result_adder_to_mux : four_adder_output;

assign mux_to_pc = jump ? jump_address : mux_to_mux;

AddModule four_adder(.a(pc), .b(32'h4), .s(four_adder_output));

AddModule alu_result_adder(.a(four_adder_output), .b(shift_left_to_alu_result_adder), .s(alu_result_adder_to_mux));

ALUModule alu(.a(regfile_read_data_1_to_alu), .b(mux_to_alu), .sel(operation), .s(alu_output), .zero(zero));

RegFileModule reg_file(.read_addr_1(instruction_memory_to_regfile_read_1), .read_addr_2(instruction_memory_to_regfile_read_2), .write_addr(mux_to_regfile_write_reg), .input_data(mux_to_regfile_write_data), .clk(clk), .enable(regWrite), .fetched_value_1(regfile_read_data_1_to_alu), .fetched_value_2(regfile_read_data_2));

InstrMemoModule instruction_memory(.read_addr(pc), .instruction(instruction_memory_output));

DataMemoModule data_memory(.address(alu_output), .input_data(regfile_read_data_2), .clk(clk), .enable_read(memRead), .enable_write(memWrite), .read_data(data_memory_to_mux));

ControlModule control(.op(instruction_memory_to_control), .jump(jump), .regDst(regDst), .aluSrc(aluSrc), .memToReg(memToReg), .regWrite(regWrite), .memRead(memRead), .memWrite(memWrite), .branch(branch), .aluOp(aluOp));

ALUControlModule alu_control(.aluOp(aluOp), .funct(funct), .operation(operation));

endmodule : Processor
