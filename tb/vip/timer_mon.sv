`define TIMER_MON_IF timer_vif.mon_cb

class timer_mon extends uvm_monitor;
  `uvm_component_utils(timer_mon)
  virtual timer_if timer_vif;
  timer_trans mon_trans;

  uvm_analysis_port #(timer_trans) timer_item_port_mon;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    mon_trans = new();
    timer_item_port_mon = new("timer_item_port_mon", this);
  endfunction

  extern virtual function void build_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);
endclass

    function void timer_mon::build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!uvm_config_db#(virtual timer_if)::get(this, "", "timer_vif", timer_vif))
        `uvm_fatal("No vif",{"virtual if must be set for: ",get_full_name(), ".timer_vif"})
    endfunction

    task timer_mon::run_phase(uvm_phase phase);
      forever begin
        mon_trans.extin   = `TIMER_MON_IF.extin;
        mon_trans.timerint= `TIMER_MON_IF.timerint;
        `uvm_info(get_type_name(), {"TIMER Mon finished collecting transfer: \n", mon_trans.sprint()}, UVM_HIGH)

        timer_item_port_mon.write(mon_trans);
      end
    endtask
