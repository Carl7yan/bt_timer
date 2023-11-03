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

  constraint c1 {
    pwrite dist {0:/20, 1:/80};
  }

  `uvn_object_utils_begin(apb_trans)
    `uvm_field_int(,UVM_ALL_ON)
  `uvm_object_utils_end

  virtual function string convert2string();
    convert2string = {
      super.convert2string(),
      $sformatf("pwrite=%s pwdata=%s paddr=%s prdata=%s pready=%s pslverr=%s",
         this.pwrite, this.pwdata, this.paddr, this,prdata, this.pready, this.pslverr)
    };
  endfunction

  virtual function string convert2string_2();
    return $sformatf("pwrite=%s pwdata=%s paddr=%s prdata=%s pready=%s pslverr=%s",
             this.pwrite, this.pwdata, this.paddr, this,prdata, this.pready, this.pslverr)
  endfunction
endclass
