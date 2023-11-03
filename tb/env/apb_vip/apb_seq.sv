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

class apb_wr_random_seq extends uvm_sequence #(apb_trans);
  `uvm_object_utils(apb_wr_random_seq)

  apb_trans trans;
  apb_cfg cfg;

  rand bit [9:0] num;
  constraint c1 {
    soft num inside {[10:1000]};
  }
  
  function new(string name = "apb_wr_random_seq");
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

task apb_wr_random_seq::body();
  trans = apb_trans::type_id::create("trans");
  cfg   = apb_cfg::type_id::create("cfg");

  for(int i = 0; i < num; i++) begin
    `uvm_do_with(trans, { trans.pwrite==1;
                          trans.paddr==cfg.paddr_cfg;
                          trans.pwdata==cfg.pwdata_cfg;
                        })
    `uvm_info(get_name(),$sformatf("random num=%d, apb_trans.convert2str()=%s", num, apb_trans.convert2str()), UVM_HIGH)
  end
  `uvm_info(get_name(),$sformatf("random done"), UVM_LOW)
endtask
