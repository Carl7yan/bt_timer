class apb_rd_test extends base_test;
  `uvm_component_utils(apb_rd_test)

  apb_rd_seq_v apb_rd_seq_v0;

  function new (string name, uvm_component parent= null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    apb_rd_seq_v0 = apb_rd_seq_v::type_id::create("apb_rd_seq_v0");
  endfunction

  virtual task run_phase(uvm_phase phase);
    //set_config_params(pwdata_cfg??, paddr_cfg??, 0);

    phase.raise_objection(.obj(this));
    apb_rd_seq_v0.start(env0.vsqr_e);
    phase.drop_objection(.obj(this));

    phase.phase_done.set_drain_time(this, 20);
  endtask
endclass
