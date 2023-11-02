class timer_agt extends uvm_agent;
  `uvm_component_utils(timer_agt)
  timer_drv drv;
  timer_sqr sqr;
  timer_mon mon;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
endclass

  function void timer_agt::build_phase(uvm_phase phase);
    super.build_phase(phase);
    mon = timer_mon::type_id::create("mon", this);
    drv = timer_drv::type_id::create("drv", this);
    sqr = timer_sqr::type_id::create("sqr", this);
  endfunction

  function void timer_agt::connect_phase(uvm_phase phase);
    //super.connect_phase(phase);
    drv.seq_item_port.connect(sqr.seq_item_export);
  endfunction
