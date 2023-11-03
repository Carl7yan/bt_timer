module tb;
  bit pclk;
  bit presetn;
  bit pclkg;

  apb_if apb_if0(pclk);
  timer_if timer_if0(pclk);

  initial begin
    forever
  end

  initial begin
    uvm_config_db#(virtual apb_if)::set(uvm_root::get(), "*", "apb_vif", apb_if0);
    uvm_config_db#(virtual timer_if)::set(uvm_root::get(), "*", "timer_vif", timer_if0);
    uvm_config_db#(uvm_object)::set(uvm_root::get(), "*", "apb_cfg", apb_cfg);
  end

  initial begin
    run_test("a_test");
  end

cmsdk_apb_timer dut

endmodule
