module tb;

logic pclk;
logic presetn;
logic pclkg;

assign pclkg = pclk;

parameter T_CLK = 1000/497.45; //497.45Mhz
always #(T_CLK/2) pclk = ~pclk;
initial begin
  pclk <= 0;
  presetn <= 0;
  #100 presetn <= 1;
end

apb_if apb_if0(pclk,presetn);
timer_if timer_if0(pclk,presetn);
apb_cfg apb_cfg0;

initial begin
  uvm_config_db#(virtual apb_if)::set(uvm_root::get(), "*", "apb_vif", apb_if0);
  uvm_config_db#(virtual timer_if)::set(uvm_root::get(), "*", "timer_vif", timer_if0);
  uvm_config_db#(uvm_object)::set(uvm_root::get(), "*", "apb_cfg", apb_cfg0);
end

initial begin
  run_test();
end

bit FSDB_ON=0;
initial begin
  void'($value$plusargs("FSDB_ON=%0d", FSDB_ON));
  if(FSDB_ON) begin
    $fsdbDumpfile("wave/tb.fsdb");
    $fsdbDumpvars(0, "tb");
  end
end

cmsdk_apb_timer dut(
  .PCLK(pclk),
  .PRESETn(presetn),
  .PCLKG(pclkg),
  .PSEL(apb_if0.psel),
  .PADDR(apb_if0.paddr),
  .PENABLE(apb_if0.penable),
  .PWRITE(apb_if0.pwrite),
  .PWDATA(apb_if0.pwdata),
  .ECOREVNUM(),
  .PRDATA(apb_if0.prdata),
  .PREADY(apb_if0.pready),
  .PSLVERR(apb_if0.pslverr),
  .EXTIN(timer_if0.extin),
  .TIMERINT(timer_if0.timerint)
);

endmodule
