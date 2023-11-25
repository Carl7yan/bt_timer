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
`include "./tc/tc_1.sv"

// ===================================================================
// fsdb
initial begin
  $fsdbDumpfile("tb.fsdb");
  $fsdbDumpvars(0,"tb");
end

// ===================================================================
// clk & rstn
parameter PERIOD_CLK = 1000/50;
always #(PERIOD_CLK/2) clk = ~clk;
initial begin
  clk                        = 1'b0;
  rst_n                      = 1'b1;
  # 100 rst_n = 1'b0;
  # 100 rst_n = 1'b1;
end

reg en;
reg [3:0] max;
wire [3:0] cnt;
// ===================================================================
// dut instance
cnt_v1 dut (
  .clk                       (clk                       ),
  .rstn                      (rst_n                     ),
  .en                        (en                        ),
  .max                       (max                       ),
  .cnt                       (cnt                       )
);

// ===================================================================
// assertion
`ifdef SOC_ASSERT_ON

`endif
endmodule
