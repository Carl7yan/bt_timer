`include "uvm_macros.svh"
import uvm_pkg::*;

//-------------------------------------------------------------------------
//	Register Class defination
//-------------------------------------------------------------------------
class ctrl extends uvm_reg;
  `uvm_object_utils(ctrl)

  //---------------------------------------
  // fields instance
  //---------------------------------------
  rand uvm_reg_field intr_en;
  rand uvm_reg_field extin_sel;
  rand uvm_reg_field extin_en;
  rand uvm_reg_field timer_en;

  //---------------------------------------
  // Constructor
  //---------------------------------------
  function new (string name = "ctrl");
    super.new(name,32,UVM_NO_COVERAGE); //32 -> Register Width
  endfunction

  //---------------------------------------
  // build_phase -
  // 1. Create the fields
  // 2. Configure the fields
  //---------------------------------------
  function void build;

    // Create bitfield
    intr_en = uvm_reg_field::type_id::create("intr_en");
    // Configure
    // status.configure(this, 32, 3, "RW", 0, 0, 1, 1, 0);
    intr_en.configure(.parent(this),
                     .size(1),
                     .lsb_pos(3),
                     .access("RW"),
                     .volatile(0),
                     .reset(0),
                     .has_reset(1),
                     .is_rand(1),
                     .individually_accessible(0));

    extin_sel = uvm_reg_field::type_id::create("extin_sel");
    extin_sel.configure(.parent(this),
                     .size(1),
                     .lsb_pos(2),
                     .access("RW"),
                     .volatile(0),
                     .reset(0),
                     .has_reset(1),
                     .is_rand(1),
                     .individually_accessible(0));

    extin_en = uvm_reg_field::type_id::create("extin_en");
    extin_en.configure(.parent(this),
                     .size(1),
                     .lsb_pos(1),
                     .access("RW"),
                     .volatile(0),
                     .reset(0),
                     .has_reset(1),
                     .is_rand(1),
                     .individually_accessible(0));

    timer_en = uvm_reg_field::type_id::create("timer_en");
    timer_en.configure(.parent(this),
                     .size(1),
                     .lsb_pos(0),
                     .access("RW"),
                     .volatile(0),
                     .reset(0),
                     .has_reset(1),
                     .is_rand(1),
                     .individually_accessible(0));

    endfunction
endclass

class value extends uvm_reg;
  `uvm_object_utils(value)

  rand uvm_reg_field cur_value;

  function new (string name = "value");
    super.new(name,32,UVM_NO_COVERAGE);
  endfunction

  function void build;
    cur_value = uvm_reg_field::type_id::create("cur_value");
    cur_value.configure(this, 32, 0, "RW", 0, 0, 1, 1, 0);
  endfunction
endclass

class reload extends uvm_reg;
  `uvm_object_utils(reload)

  rand uvm_reg_field reload_value;

  function new (string name = "reload");
    super.new(name,32,UVM_NO_COVERAGE);
  endfunction

  function void build;
    reload_value = uvm_reg_field::type_id::create("reload_value");
    reload_value.configure(this, 32, 0, "RW", 0, 0, 1, 1, 0);
  endfunction
endclass

class intr extends uvm_reg;
  `uvm_object_utils(intr)

  rand uvm_reg_field intr_v;

  function new (string name = "intr");
    super.new(name,32,UVM_NO_COVERAGE);
  endfunction

  function void build;
    intr_v = uvm_reg_field::type_id::create("intr_v");
    intr_v.configure(this, 1, 0, "RW", 0, 0, 1, 1, 0);
  endfunction
endclass

//-------------------------------------------------------------------------
//	Register Block Definition
//-------------------------------------------------------------------------
class timer_reg_model extends uvm_reg_block;
  `uvm_object_utils(timer_reg_model)

  //---------------------------------------
  // register instances
  //---------------------------------------
  rand ctrl 	reg_ctrl;
  rand value   	reg_value;
  rand reload   reg_reload;
  rand intr 	reg_intr;

  //---------------------------------------
  // Constructor
  //---------------------------------------
  function new (string name = "");
    super.new(name, build_coverage(UVM_NO_COVERAGE));
  endfunction

  //---------------------------------------
  // Build Phase
  //---------------------------------------
  function void build;

    //---------------------------------------
    //reg creation
    //---------------------------------------
    reg_ctrl = ctrl::type_id::create("reg_ctrl");
    reg_ctrl.build();
    reg_ctrl.configure(this);

    reg_value = value::type_id::create("reg_value");
    reg_value.build();
    reg_value.configure(this);

    reg_reload = reload::type_id::create("reload");
    reg_reload.build();
    reg_reload.configure(this);

    reg_intr = intr::type_id::create("reg_intr");
    reg_intr.build();
    reg_intr.configure(this);
    //r0.add_hdl_path_slice("r0", 0, 8);      // name, offset, bitwidth

    //---------------------------------------
    //Memory map creation and reg map to it
    //---------------------------------------
    default_map = create_map("my_map", 0, 4, UVM_LITTLE_ENDIAN); // name, base, nBytes
    default_map.add_reg(reg_ctrl, 'h0, "RW");
    default_map.add_reg(reg_value, 'h4, "RW");
    default_map.add_reg(reg_reload, 'h8, "RW");
    default_map.add_reg(reg_intr, 'hc, "RW");  // reg, offset, access

    lock_model();
  endfunction
endclass
