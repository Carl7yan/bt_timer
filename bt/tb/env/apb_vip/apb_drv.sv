`define APB_DRV_CB apb_vif.drv_cb

class apb_drv extends uvm_driver #(apb_trans);
  `uvm_component_utils(apb_drv)
  virtual apb_if apb_vif;
  apb_cfg  apb_cfg_drv;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);
  extern virtual task drive(apb_trans req);
endclass

    function void apb_drv::build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!uvm_config_db#(apb_cfg)::get(this,"","apb_cfg",apb_cfg_drv))
        `uvm_fatal("No apb_cfg",{"Configuration must be set for: ", get_full_name(), ".apb_cfg"});
    endfunction

    function void apb_drv::connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      if(!uvm_config_db#(virtual apb_if)::get(this, "", "apb_vif", apb_vif))
        `uvm_fatal("No vif",{"virtual if must be set for: ", get_full_name(), ".apb_vif"});
    endfunction

    task apb_drv::run_phase(uvm_phase phase);
      apb_trans req;
      @(posedge apb_vif.pclkg iff apb_vif.presetn)
      forever begin
        `APB_DRV_CB.psel    <= 0;
        `APB_DRV_CB.penable <= 0;
        `APB_DRV_CB.pwrite  <= 0;
        `APB_DRV_CB.pwdata  <= 0;
        `APB_DRV_CB.paddr   <= 0;

        `uvm_info(get_full_name(), $sformatf("wait for item from sqr"), UVM_HIGH)
        seq_item_port.get_next_item(req);
        if(apb_cfg_drv.psel_cfg)
          drive(req);
        `uvm_info("APB_DRV", $sformatf("APB driver finished driving transfer \n%s", req.sprint()), UVM_HIGH)
        seq_item_port.item_done();
      end
    endtask

    task apb_drv::drive(apb_trans req);
          `APB_DRV_CB.psel   <= apb_cfg_drv.psel_cfg;
          `APB_DRV_CB.pwrite <= req.pwrite;
          `APB_DRV_CB.paddr  <= req.paddr;
          `APB_DRV_CB.pwdata <= req.pwdata;
          // access state
          @(`APB_DRV_CB);
          `APB_DRV_CB.penable    <= 1;
          wait(`APB_DRV_CB.pready)
          @(`APB_DRV_CB);
          `APB_DRV_CB.psel       <= 0;
          `APB_DRV_CB.penable    <= 0;
    endtask
