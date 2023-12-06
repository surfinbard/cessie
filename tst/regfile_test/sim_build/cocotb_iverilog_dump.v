module cocotb_iverilog_dump();
initial begin
    $dumpfile("sim_build/RegFile.fst");
    $dumpvars(0, RegFile);
end
endmodule
