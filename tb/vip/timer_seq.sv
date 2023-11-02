class timer_wr_extin1_seq extends uvm_sequence #(timer_trans);
  `uvm_object_utils(timer_wr_seq)

  timer_trans trans;

  function new(string name = "timer_wr_extin1_seq");
    super.new(name);
  endfunction

  extern virtual task body();
endclass

class timer_wr_extin0_seq extends uvm_sequence #(timer_trans);
  `uvm_object_utils(timer_wr_seq)

  timer_trans trans;

  function new(string name = "timer_wr_extin0_seq");
    super.new(name);
  endfunction

  extern virtual task body();
endclass

task timer_extin1_seq::body();
  trans = timer_trans::type_id::create("trans");
  
  `uvm_do_with(trans, { trans.extin==1;})
endtask

task timer_extin0_seq::body();
  trans = timer_trans::type_id::create("trans");
  
  `uvm_do_with(trans, { trans.extin==0;})
endtask

