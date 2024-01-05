module InstrMemoModule
import types::*;
(   
    input  bus_type read_addr,
    output bus_type instruction
);

reg [7:0] registers[0:96];
bus_type nome_qualquer[0:31];

assign instruction = {registers[read_addr + 3], registers[read_addr + 2], registers[read_addr + 1], registers[read_addr + 0]};

integer i;

initial begin
    $readmemh("/home/criptido/mips-32-subset/hextextfib.txt", nome_qualquer, 0, 31);
    
    for (i=0; i< 31;  i = i+1) begin
        {registers[4*i + 3], registers[4*i + 2], registers[4*i + 1], registers[4*i + 0]} = nome_qualquer[i];
    end
end

endmodule : InstrMemoModule