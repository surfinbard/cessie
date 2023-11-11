module cocotb_iverilog_dump();
initial begin
    $dumpfile("sim_build/Aritmethic.fst");
    $dumpvars(0, Aritmethic);
end
endmodule
