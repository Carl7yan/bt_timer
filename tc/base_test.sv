`define APB_DRV_CB apb_vif.drv_cb

class base_test extends uvm_test;
  `uvm_component_utils(base_test)
  env env0;
  apb_cfg apb_cfg0;
  virtual apb_if apb_vif;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env0 = env::type_id::create("env0", this);

    apb_cfg0=new();
    uvm_config_db#(apb_cfg)::set(this, "*", "apb_cfg", apb_cfg0);

    if(!uvm_config_db#(virtual apb_if)::get(this, "", "apb_vif", apb_vif))
      `uvm_fatal("TEST", "Did not get apb_vif")
    //set_config_params();
  endfunction

  function set_config_params(input bit [31:0] pwdata_cfg, input bit [11:2] paddr_cfg, input bit randomize_flag);
    if(randomize_flag) begin
      if(!apb_cfg0.randomize())
        `uvm_error("RANDOM FAIL", "apb_cfg random failed")
    end else begin
      apb_cfg0.pwdata_cfg = pwdata_cfg;
      apb_cfg0.paddr_cfg  = paddr_cfg;
    end
  endfunction

  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
      apb_vif.presetn <= 0;
      repeat(10) @(`APB_DRV_CB)
      apb_vif.presetn <= 1;
      repeat(10) @(`APB_DRV_CB)
    phase.drop_objection(this);
  endtask

  function void report_phase(uvm_phase phase);
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
