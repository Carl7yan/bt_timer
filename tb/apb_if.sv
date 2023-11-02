interface apb_if(input pclkg, presetn);
  logic psel;
  logic penable;
  logic pwrite;
  logic [11:2] paddr;
  logic [31:0] pwdata;
  logic [31:0] prdata;
  logic pready;
  logic pslverr;
  
  clocking drv_cb @(posedge pclkg);
    default input #1 output #1;
    output psel;
    output penable;
    output pwrite;
    output paddr;
    output pwdata;
    input  pready;
    input  pslverr;
    input  prdata;
  endclocking

  clocking mon_cb @(posedge pclkg);
    default input #1;
    input psel;
    input penable;
    input pwrite;
    input paddr;
    input pwdata;
    input pready;
    input pslverr;
    input prdata;
  endclocking
  
endinterface
