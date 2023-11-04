`include "uvm_macros.svh"
import uvm_pkg::*;

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

  constraint c1 {
    pwrite dist {0:/20, 1:/80};
  }

  `uvm_object_utils_begin(apb_trans)
    `uvm_field_int(pwrite,UVM_ALL_ON)
    `uvm_field_int(paddr,UVM_ALL_ON)
    `uvm_field_int(pwdata,UVM_ALL_ON)
    `uvm_field_int(prdata,UVM_ALL_ON)
    `uvm_field_int(pready,UVM_ALL_ON)
    `uvm_field_int(pslverr,UVM_ALL_ON)
  `uvm_object_utils_end

  virtual function string convert2str();
    convert2str = {
      //super.convert2str(),
      $sformatf("pwrite=%d pwdata=%d paddr=%d prdata=%d pready=%d pslverr=%d",
         this.pwrite, this.pwdata, this.paddr, this,prdata, this.pready, this.pslverr)
    };
  endfunction

  virtual function string convert2str_2();
    return $sformatf("pwrite=%d pwdata=%d paddr=%d prdata=%d pready=%d pslverr=%d",
      this.pwrite, this.pwdata, this.paddr, this,prdata, this.pready, this.pslverr);
  endfunction
endclass
