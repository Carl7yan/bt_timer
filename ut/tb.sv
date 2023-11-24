// ===================================================================
// Copyright (c) 2023 Carl Yan
// Owner      : carl.shengjie.yan@gmail.com
// Date       :
// Filename   :
// Abstract   :
//
// ===================================================================

module tb;
// ===================================================================
// parameters
parameter FIFO_DEPTH         = 16;
parameter DATA_WIDTH         = 32;
parameter ADDR_WIDTH         = $clog2(FIFO_DEPTH);
parameter CNT_WIDTH          = ((FIFO_DEPTH & (FIFO_DEPTH-1)) == 0) ? (ADDR_WIDTH+1) : ADDR_WIDTH;

// ===================================================================
// inner signals
reg                          clk;
reg                          rst_n;

// ===================================================================
// testcase
`include "./tc/testcase.sv"

// ===================================================================
// fsdb
initial begin
  $fsdbDumpfile("tb.fsdb");
  $fsdbDumpvars(0,"tb");
end

// ===================================================================
// clk & rstn
always #(PERIOD_CLK/2) clk = ~clk;
initial begin
  clk                        = 1'b0;
  rst_n                      = 1'b1;
  # 100 rst_n = 1'b0;
  # 100 rst_n = 1'b1;
end

// ===================================================================
// dut instance
rtl#(
  .ADDR_WIDTH                (ADDR_WIDTH                ),
  .ADDR_WIDTH                (ADDR_WIDTH                ),
  .CNT_WIDTH                 (CNT_WIDTH                 )
) dut (
  .aempty_th                 (aempty_th                 ),
  .aempty                    (aempty                    ),
  .cnt                       (cnt                       )
);

// ===================================================================
// assertion
`ifdef SOC_ASSERT_ON

`endif
endmodule
