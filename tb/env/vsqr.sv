class vsqr extends uvm_sequencer;
  `uvm_component_utils(vsqr)
  apb_sqr apb_sqr_v;
  timer_sqr timer_sqr_v;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  extern virtual function void end_of_elaboration_phase(uvm_phase phase);
endclass

  function void vsqr::end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    if(!uvm_config_db#(apb_sqr)::get(this, "", "apb_sqr", apb_sqr_v);
      `uvm_fatal(get_full_name(), "No apb_sqr specified in vsqr");
    if(!uvm_config_db#(timer_sqr)::get(this, "", "timer_sqr", timer_sqr_v);
      `uvm_fatal(get_full_name(), "No timer_sqr specified in vsqr");    
  endfunction
