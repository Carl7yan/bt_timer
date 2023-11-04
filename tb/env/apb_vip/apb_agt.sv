class apb_agt extends uvm_agent;
  `uvm_component_utils(apb_agt)
  apb_drv drv;
  apb_sqr sqr;
  apb_mon mon;
  apb_cfg cfg;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
endclass

  function void apb_agt::build_phase(uvm_phase phase);
    super.build_phase(phase);
    mon = apb_mon::type_id::create("mon", this);

    if(!uvm_config_db#(apb_cfg)::get(this, "", "apb_cfg", cfg))
      `uvm_fatal("No cfg", {"apb_cfg must be set for: ", get_full_name(), ".apb_cfg"});

    if(cfg.is_active == UVM_ACTIVE) begin
      drv = apb_drv::type_id::create("drv", this);
      sqr = apb_sqr::type_id::create("sqr", this);
    end
  endfunction

  function void apb_agt::connect_phase(uvm_phase phase);
    //super.connect_phase(phase);
    if(cfg.is_active == UVM_ACTIVE)
      drv.seq_item_port.connect(sqr.seq_item_export);
  endfunction
