// `include "uvm_macros.svh"
// import uvm_pkg::*;

class apb_trans extends uvm_sequence_item;
  rand logic pwrite;
  rand logic [31:0] pwdata;
  rand logic [11:2] paddr;
  logic [31:0] prdata;
  logic pready;
  logic pslverr;

  function new(string name = "apb_trans");
    super.new(name);
  endfunction

  `uvn_object_utils_begin(apb_trans)
    `uvm_field_int(,UVM_ALL_ON)
  `uvm_object_utils_end
endclass
