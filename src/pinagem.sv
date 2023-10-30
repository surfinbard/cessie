module top(
input logic[0:20] SW,
input logic[0:3] KEY,
output logic[7:10] LEDR,
output logic[0:8] LEDG,
output logic[0:6] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7);

logic[0:7] hi, lo;

import types::*;
Aritmethic mul(.b(SW[0:7]),
.a(SW[8:15]),
.sel(types::oper_t'(SW[16:20])),
.start(~KEY[0]),
.hi(hi),
.lo(lo); 

bin2segment i0(SW[0:3], HEX4);
bin2segment i1(SW[4:7], HEX5);
bin2segment i2(SW[8:11], HEX6);
bin2segment i3(SW[12:15], HEX7);

bin2segment o0(lo[0:3], HEX0);
bin2segment o1(lo[4:7], HEX1);
bin2segment o2(hi[0:3], HEX2);
bin2segment o3(hi[4:7], HEX3);

assign LEDR[8:15] = 8'b1111_1111;
assign LEDG[7:12]KEY[3];
assign LEDG[1] = ~KEY[0];
//assign LEDG[5] = CLOCK_50;

endmodule

module bin2segment(
input logic[0:3] in,
output logic[0:6] out);

always_comb begin
case (in)
0: out = ~7'b011_1111;
1: out = ~7'b000_0110;
2: out = ~7'b101_1011;
3: out = ~7'b100_1111;
4: out = ~7'b110_0110;
5: out = ~7'b110_1101;
6: out = ~7'b111_1101;
7: out = ~7'b000_0111;
8: out = ~7'b111_1111;
9: out = ~7'b110_0111;
10: out = ~7'b111_0111;
11: out = ~7'b111_1100;
12: out = ~7'b011_1001;
13: out = ~7'b101_1110;
14: out = ~7'b111_1001;
15: out = ~7'b111_0001;
endcase
end
endmodule