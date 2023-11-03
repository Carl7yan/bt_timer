`define APB_MON_IF apb_vif.mon_cb

class apb_mon extends uvm_monitor;
  `uvm_component_utils(apb_mon)
  virtual apb_if apb_vif;
  apb_trans mon_trans;

  uvm_analysis_port #(apb_trans) apb_item_port_mon;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    mon_trans = new();
    apb_item_port_mon = new("apb_item_port_mon", this);
  endfunction

  extern virtual function void build_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);
endclass

    function void apb_mon::build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!uvm_config_db#(virtual apb_if)::get(this, "", "apb_vif", apb_vif))
        `uvm_fatal("No vif",{"virtual if must be set for: ",get_full_name(), ".apb_vif"})
    endfunction

    task apb_mon::run_phase(uvm_phase phase);
      forever begin
        wait(`APB_MON_IF.psel   && `APB_MON_IF.penable);
        wait(`APB_MON_IF.pready);

        mon_trans.pwrite  = `APB_MON_IF.pwrite;
        mon_trans.pwdata  = `APB_MON_IF.pwdata;
        mon_trans.paddr   = `APB_MON_IF.paddr;
        mon_trans.prdata  = `APB_MON_IF.prdata;
        mon_trans.pready  = `APB_MON_IF.pready;
        mon_trans.pslverr = `APB_MON_IF.pslverr;
        `uvm_info(get_type_name(), {"APB Mon finished collecting transfer: \n", mon_trans.sprint()}, UVM_HIGH)
        `uvm_info("MON", $sformatf("get item $s", mon_trans.convert2str()), UVM_HIGH)

        apb_item_port_mon.write(mon_trans);
      end
    endtask
