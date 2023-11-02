class apb_wr_seq extends uvm_sequence #(apb_trans);
  `uvm_object_utils(apb_wr_seq)

  apb_trans trans;
  apb_cfg cfg;

  function new(string name = "apb_wr_seq");
    super.new(name);
  endfunction

  extern virtual task body();
endclass

class apb_rd_seq extends uvm_sequence #(apb_trans);
  `uvm_object_utils(apb_rd_seq)

  apb_trans trans;
  apb_cfg cfg;

  function new(string name = "apb_rd_seq");
    super.new(name);
  endfunction

  extern virtual task body();
endclass

task apb_wr_seq::body();
  trans = apb_trans::type_id::create("trans");
  cfg   = apb_cfg::type_id::create("cfg");
  
  `uvm_do_with(trans, { trans.pwrite==1;
                        trans.paddr==cfg.paddr_cfg;
                        trans.pwdata==cfg.pwdata_cfg;
                      })
endtask

task apb_rd_seq::body();
  trans = apb_trans::type_id::create("trans");
  cfg   = apb_cfg::type_id::create("cfg");
  
  `uvm_do_with(trans, { trans.pwrite==0;
                        trans.paddr==cfg.paddr_cfg;
                      })
endtask