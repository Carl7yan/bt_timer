class env extends uvm_env;
  `uvm_component_utils(env);

  apb_agt apb_agt_e;
  timer_agt timer_agt_e;
  scb scb_e;
  vsqr vsqr_e;

  timer_reg_model regmodel;
  timer_adapter m_adapter;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
endclass

    function void env::build_phase(uvm_phase phase);
      super.build_phase(phase);
      apb_agt_e = apb_agt::type_id::create("apb_agt_e", this);
      timer_agt_e = timer_agt::type_id::create("timer_agt_e", this);
      scb_e = scb::type_id::create("scb_e", this);
      vsqr_e = vsqr::type_id::create("vsqr_e", this);

      regmodel = timer_reg_model::type_id::create("regmodel", this);
      regmodel = build();
      m_adapter = timer_adapter::type_id::create("m_adapter", , get_full_name() );
    endfunction

    function void env::connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      apb_agt_e.mon.apb_item_port_mon.connect(scb_e.item_imp_apbmon);
      timer_agt_e.mon.timer_item_port_mon.connect(scb_e.item_imp_timermon);

      uvm_config_db#(apb_sqr)::set(this,"*","apb_sqr",apb_agt_e.sqr);
      uvm_config_db#(timer_sqr)::set(this,"*","timer_sqr",timer_agt_e.sqr);

      regmodel.defaule_map.set_sequencer(.sequencer(apb_agent_e.sqr), .adapter(m_adapter) );
      regmodel.defaule_map.set_base_addr('h000);
    endfunction
