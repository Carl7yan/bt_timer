`define TIMER_DRV_IF timer_vif.drv_cb

class timer_drv extends uvm_driver #(timer_trans);
  `uvm_component_utils(timer_drv)
  virtual timer_if timer_vif;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);
endclass

    function void timer_drv::build_phase(uvm_phase phase);
      super.build_phase(phase);
    endfunction

    function void timer_drv::connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      if(!uvm_config_db#(virtual timer_if)::get(this, "", "timer_vif" timer_vif))
        `uvm_fatal("No vif",{"virtual if must be set for: ", get_full_name(), ".timer_vif"});
    endfunction

    task timer_drv::run_phase(uvm_phase phase);
      timer_trans req;
      forever begin
        `TIMER_DRV_IF.extin   <= 0;

        seq_item_port.get_next_item(req);
	`TIMER_DRV_IF.extin   <= req.extin;
        `uvm_info("TIMER_DRV", $sformatf("TIMER driver finished driving transfer \n%s", req.sprint()), UVM_HIGH)
        seq_item_port.item_done();
      end
    endtask
