class timer_ral_test extends base_test;
  `uvm_component_utils(timer_ral_test)

  timer_reg_sequence reg_seq;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    reg_seq = timer_reg_sequence::type_id::create("reg_seq");
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);

    if ( !reg_seq.randomize() ) `uvm_error("", "Randomize failed")

    //Setting sequence in reg_seq
    reg_seq.regmodel       = env0.regmodel;
    reg_seq.starting_phase = phase;
    reg_seq.start(env0.apb_agt_e.sqr);

    phase.drop_objection(this);

    phase.phase_done.set_drain_time(this, 50);
  endtask

endclass
