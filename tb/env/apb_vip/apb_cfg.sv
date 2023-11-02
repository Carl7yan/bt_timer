`define CTRL_ADDR    10'h000>>2
`define VALUE_ADDR   10'h004>>2
`define RELOAD_ADDR  10'h008>>2
`define INT_ADDR     10'h00c>>2

`define PID4         10'hfd0>>2
`define PID5         10'hfd4>>2
`define PID6         10'hfd8>>2
`define PID7         10'hfdc>>2
`define PID0         10'hfe0>>2
`define PID1         10'hfe4>>2
`define PID2         10'hfe8>>2
`define PID3         10'hfec>>2

`define CID0         10'hff0>>2
`define CID1         10'hff4>>2
`define CID2         10'hff8>>2
`define CID3         10'hffc>>2


class apb_cfg extends uvm_object;
  rand bit [31:0] pwdata_cfg;
  rand bit [11:2] paddr_cfg;
  bit psel_cfg;

  uvm_active_passive_enum is_active = UVM_ACTIVE;

  `uvm_object_utils_begin(apb_cfg)
    `uvm_field_int(pwdata_cfg, UVM_DEFAULT)
    `uvm_field_int(paddr_cfg, UVM_DEFAULT)
    `uvm_field_int(psel_cfg, UVM_DEFAULT)
    `uvm_field_enum(uvm_active_passive_enum, is_active, UVM_ALL_ON)
  `uvm_object_utils_end
  
  function void ADDR_CALC();
    if((paddr_cfg>=`CRTL_ADDR)&&(paddr_cfg<=`INT_ADDR))||((paddr_cfg>=`PID4)&&(paddr_cfg<=`CID3))
      psel_cfg=1;
  endfunction

  function new(string name = "apb_cfg")
    fuper.new(name);
  endfunction
endclass
