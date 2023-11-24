class timer_trans extends uvm_sequence_item;
  rand logic extin;
  logic timerint;

  function new(string name = "timer_trans");
    super.new(name);
  endfunction

  `uvm_object_utils_begin(timer_trans)
    `uvm_field_int(extin,UVM_ALL_ON)
    `uvm_field_int(timerint,UVM_ALL_ON)
  `uvm_object_utils_end

  virtual function string convert2str();
    convert2str = {
      //super.convert2str(),
      $sformatf("extin=%s timerint=%s", this.extin, this.timerint)
    };
  endfunction
endclass
