//`default_nettype none
`ifndef _WIDTH_
`define _WIDTH_ 32
`endif

package types;
  parameter int WIDTH = `_WIDTH_;

  typedef logic [0:WIDTH-1] bus_t;
  typedef logic [0:$clog2(WIDTH)] bus_logsize_t;

  typedef enum logic [0:3] {
    AND  = 4'b0000,
    OR   = 4'b0001,
    ADD  = 4'b0010,
    SUB  = 4'b0110,
    SLT  = 4'b0111,
    NOR  = 4'b1100,
    SLTU = 4'b1101
  } ula_oper_t;
endpackage
