class base_test extends uvm_test;
  `uvm_component_utils(base_test)
  env env0;
  apb_cfg apb_cfg0;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function build_phase(uvm_phase phase);
    super.build_phase(phase);
    env0 = env::type_id::create("env0", this);

    apb_cfg0=new();
    uvm_config_db#(apb_cfg)::set(this, "*", "apb_cfg", apb_cfg0);
    set_config_params();
  endfunction

  function set_config_params(input bit [31:0] pwdata_cfg, input bit [11:2] paddr_cfg, input bit randomize_flag);
    if(randomize_flag) begin
      if(!apb_cfg0.randomize())
        `uvm_error("RANDOM FAIL", "apb_cfg random failed")
    end else begin
      cfg.pwdata_cfg = pwdata_cfg;
      cfg.paddr_cfg  = paddr_cfg;
    end
  endfunction

  function report_phase(uvm_phase phase);
    uvm_report_server svr;
    super.report_phase(phase);

    svr=uvm_report_server::get_server();
    if((svr.get_severity_count(UVM_FATAL) + svr.get_severity_count(UVM_ERROR)) > 0) begin
      `uvm_info(get_type_name(), "---------------------------------------", UVM_NONE)
      `uvm_info(get_type_name(), "----            TEST FAIL          ----", UVM_NONE)
      `uvm_info(get_type_name(), "---------------------------------------", UVM_NONE)
    end else begin
      `uvm_info(get_type_name(), "---------------------------------------", UVM_NONE)
      `uvm_info(get_type_name(), "----           TEST PASS           ----", UVM_NONE)
      `uvm_info(get_type_name(), "---------------------------------------", UVM_NONE)
    end
  endfunction

endclass