//-------------------------------------------------------------------------
//	Register Access Sequence
//-------------------------------------------------------------------------
class timer_reg_sequence extends uvm_sequence;

  `uvm_object_utils(timer_reg_sequence)

  timer_reg_model regmodel;

  //---------------------------------------
  // Constructor
  //---------------------------------------
  function new (string name = "");
    super.new(name);
  endfunction

  //---------------------------------------
  // Sequence body
  //---------------------------------------
  task body;
    uvm_status_e   status;
    uvm_reg_data_t incoming;
    bit [31:0]     rdata;

    if (starting_phase != null)
      starting_phase.raise_objection(this);

    //Write to the Registers
    regmodel.reg_ctrl.write(status, 32'h0000_000f);
    regmodel.reg_value.write(status, 32'h1111_2222);
    regmodel.reg_reload.write(status, 32'h3333_4444);
    regmodel.reg_intr.write(status, 32'h0000_0001);

    //Read from the registers
    regmodel.reg_ctrl.read(status, rdata);
    regmodel.reg_value.read(status, rdata);
    regmodel.reg_reload.read(status, rdata);
    regmodel.reg_intr.read(status, rdata);

    if (starting_phase != null)
      starting_phase.drop_objection(this);

  endtask
endclass
