class timer_wr_extin1_test extends base_test;
  `uvm_component_utils(timer_wr_extin1_test)

  timer_wr_extin1_seq_v timer_wr_extin1_seq_v0;

  function new (string name, uvm_component parent= null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    timer_wr_extin1_seq_v0 = timer_wr_extin1_seq_v::type_id::create("timer_wr_extin1_seq_v0");
  endfunction

  virtual task run_phase(uvm_phase phase);
    fork
      begin
        //set_config_params(pwdata_cfg??, paddr_cfg??, 0);

        phase.raise_objection(.obj(this));
    timer_wr_extin1_seq_v0.start(env0.vsqr_e);
        phase.drop_objection(.obj(this));

        phase.phase_done.set_drain_time(this, 20);
      end
      begin
        #1ms;
        ERR_CNT=ERR_CNT+1;
        `uvm_info(get_name(), "------------------timeout------------------", UVM_LOW)
      end
    join

  endtask

endclass
