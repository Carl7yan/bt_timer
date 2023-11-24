`define CTRL_ADDR    10'h000>>2
`define VALUE_ADDR   10'h004>>2
`define RELOAD_ADDR  10'h008>>2
`define INT_ADDR     10'h00c>>2

class apb_cfg extends uvm_object;
  rand bit [31:0] pwdata_cfg;
  rand bit [11:2] paddr_cfg;
  bit psel_cfg;

  // const bit [9:0] ctrl_addr = 10'h000>>2
  // ...

  uvm_active_passive_enum is_active = UVM_ACTIVE;

  `uvm_object_utils_begin(apb_cfg)
    `uvm_field_int(pwdata_cfg, UVM_DEFAULT)
    `uvm_field_int(paddr_cfg, UVM_DEFAULT)
    `uvm_field_int(psel_cfg, UVM_DEFAULT)
    `uvm_field_enum(uvm_active_passive_enum, is_active, UVM_ALL_ON)
  `uvm_object_utils_end

  function void ADDR_CALC();
    if( (paddr_cfg>=`CTRL_ADDR)&&(paddr_cfg<=`INT_ADDR) )
      psel_cfg=1;
  endfunction

  constraint c_psel {psel_cfg inside {0, 1};}

  function new(string name = "apb_cfg");
    super.new(name);
  endfunction
endclass
