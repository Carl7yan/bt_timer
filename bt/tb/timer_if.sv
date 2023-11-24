interface timer_if(input pclk, input presetn);
  logic extin;
  logic timerint;

  clocking drv_cb @(posedge pclk);
    default input #1 output #1;
    output extin;
    input  timerint;
  endclocking

  clocking mon_cb @(posedge pclk);
    default input #1;
    input extin;
    input timerint;
  endclocking

endinterface
