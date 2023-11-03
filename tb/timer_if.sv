interface apb_if(input pclk);
  logic presetn;
  logic extin;
  logic timerint; 

  clocking drv_cb @(posedge pclk);
    default input #1 output #1;
    output presetn;
    output extin;
    input  timerint;
  endclocking

  clocking mon_cb @(posedge pclk);
    default input #1;
    input presetn;
    input extin;
    input timerint;
  endclocking
  
endinterface
