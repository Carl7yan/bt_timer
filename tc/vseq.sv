class vseq_base extends uvm_sequence;
  `uvm_object_utils(vseq_base)
  `uvm_declare_p_sequencer(vsqr)

  apb_sqr apb_sqr_v;
  timer_sqr timer_sqr_v;

  function new(string name = "vseq_base");
    super.new(name);
  endfunction

  extern virtual task body();
endclass

class apb_wr_seq_v extends vseq_base;
  `uvm_object_utils(apb_wr_seq_v)

  function new(string name = "apb_wr_seq_v");
    super.new(name);
  endfunction

  extern virtual task body();
endclass

class apb_rd_seq_v extends vseq_base;
  `uvm_object_utils(apb_rd_seq_v)

  function new(string name = "apb_rd_seq_v");
    super.new(name);
  endfunction

  extern virtual task body();
endclass

class timer_wr_extin1_seq_v extends vseq_base;
  `uvm_object_utils(timer_wr_extin1_seq_v)

  function new(string name = "timer_wr_extin1_seq_v");
    super.new(name);
  endfunction

  extern virtual task body();
endclass

class timer_wr_extin0_seq_v extends vseq_base;
    `uvm_object_utils(timer_wr_extin0_seq_v)

    function new(string name = "timer_wr_extin0_seq_v");
    super.new(name);
  endfunction

  extern virtual task body();
endclass


    task vseq_base::body();
      apb_sqr_v = p_sequencer.apb_sqr_v;
      timer_sqr_v = p_sequencer.timer_sqr_v;
    endtask

    task apb_wr_seq_v::body();
      // why? sequence should be instanced before super.body()
      apb_wr_seq apb_wr_seq0;
      super.body();
      `uvm_info(get_full_name(), "executing sequence", UVM_HIGH)
      `uvm_do_on(apb_wr_seq0, apb_sqr_v)
      `uvm_info(get_full_name(), "completing sequence", UVM_HIGH)
    endtask

    task apb_rd_seq_v::body();
      apb_rd_seq apb_rd_seq0;
      super.body();
      `uvm_info(get_full_name(), "executing sequence", UVM_HIGH)
      `uvm_do_on(apb_rd_seq0, apb_sqr_v)
      `uvm_info(get_full_name(), "completing sequence", UVM_HIGH)
    endtask

    task timer_wr_extin1_seq_v::body();
      timer_wr_extin1_seq timer_wr_extin1_seq0;
      super.body();
      `uvm_info(get_full_name(), "executing sequence", UVM_HIGH)
      `uvm_do_on(timer_wr_extin1_seq0, timer_sqr_v)
      `uvm_info(get_full_name(), "completing sequence", UVM_HIGH)
    endtask

    task timer_wr_extin0_seq_v::body();
      timer_wr_extin0_seq timer_wr_extin0_seq0;
      super.body();
      `uvm_info(get_full_name(), "executing sequence", UVM_HIGH)
      `uvm_do_on(timer_wr_extin0_seq0, timer_sqr_v)
      `uvm_info(get_full_name(), "completing sequence", UVM_HIGH)
    endtask
