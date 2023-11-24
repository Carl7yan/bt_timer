// ----------------------------------------------------------
// ongoing!!! Not finished

class timer_adapter extends uvm_reg_adapter;
  `uvm_object_utils (timer_adapter)

  function new (string name = "timer_adapter");
      super.new (name);
   endfunction

  function uvm_sequence_item reg2bus(const ref uvm_reg_bus_op rw);
    apb_trans tx;
    tx = apb_trans::type_id::create("tx");

    tx.pwrite= (rw.kind == UVM_WRITE);
    tx.paddr = rw.addr;
    if (tx.pwrite) tx.pwdata = rw.data;
    if (!tx.pwrite) tx.prdata = rw.data;
    if (tx.pwrite) $display("[Adapter: reg2bus] WR: Addr=%0h, Data=%0h",tx.paddr,tx.pwdata);
    if (!tx.pwrite) $display("[Adapter: reg2bus] RD: Addr=%0h",tx.paddr);
    return tx;
  endfunction

  function void bus2reg(uvm_sequence_item bus_item, ref uvm_reg_bus_op rw);
    apb_trans tx;

    assert( $cast(tx, bus_item) )
      else `uvm_fatal("", "A bad thing has just happened in my_adapter")

    rw.kind = tx.pwrite ? UVM_WRITE : UVM_READ;
    rw.addr = tx.paddr;
    rw.data = tx.prdata;

    if(rw.kind == UVM_READ) $display("[Adapter: bus2reg] RD: Addr=%0h, Data=%0h",tx.paddr,tx.prdata);
    rw.status = UVM_IS_OK;
  endfunction
endclass
