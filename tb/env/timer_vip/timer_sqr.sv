class timer_sqr extends uvm_sequencer#(timer_trans);
  `uvm_component_utils(timer_sqr)
  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction
endclass
