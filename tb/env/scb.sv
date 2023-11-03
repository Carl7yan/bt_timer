`uvm_analysis_imp_decl(_apbmon)
`uvm_analysis_imp_decl(_timermon)

class scb extends uvm_scoreboard;
  `uvm_component_utils(scb)

  apb_trans apb_mon_pkt_q[$];
  timer_trans timer_mon_pkt_q[$];
  logic [11:2] paddr_r;
  logic [31:0] pwdata_r;
  logic [31:0] prdata_r;

  logic ref_value;

  apb_trans apb_cov_trans;
  timer_trans timer_cov_trans;
  covergroup cov;
    a: coverpoint apb_cov_trans.pwrite;
    b: coverpoint apb_cov_trans.paddr;
    c: coverpoint apb_cov_trans.pwdata;
    d: coverpoint apb_cov_trans.prdata;
    e: coverpoint timer_cov_trans.extin;
    f: coverpoint timer_cov_trans.timerint;
    cross a, b;
  endgroup

  uvm_analysis_imp_apbmon #(apb_trans, scb) item_imp_apbmon;
  uvm_analysis_imp_timermon #(timer_trans, scb) item_imp_timermon;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    cov = new();
  endfunction

  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void write_apbmon(apb_trans pkt);
  extern virtual function void write_timermon(timer_trans pkt);
  extern virtual function void run_phase(uvm_phase phase);
  extern virtual function void compare();

endclass

    // you can directly make a comparation in write() methods; 
    function void scb::write_apbmon(apb_trans pkt);
      apb_mon_pkt_q.push_back(pkt);
      `uvm_info(get_full_name(), "scb got apb trans" UVM_MEDIUM)
    endfunction

    function void scb::write_timermon(timer_trans pkt);
      timer_mon_pkt_q.push_back(pkt);
      `uvm_info(get_full_name(), "scb got timer trans" UVM_MEDIUM)
    endfunction
    
    function void scb::build_phase(uvm_phase phase);
      super.build_phase(phase);
      item_imp_apbmon = new("item_imp_apbmon", this);
      item_imp_timermon = new("item_imp_timermon", this);
    endfunction

    task scb::run_phase(uvm_phase phase);
      apb_trans apb_mon_pkt;
      timer_trans timer_mon_pkt;
      forever begin
        wait(apb_mon_pkt_q.size() > 0);
        apb_mon_pkt = apb_mon_pkt_q.pop_front();
	apb_cov_trans = apb_mon_pkt;
	cov.sample();
        if(apb_mon_pkt.pwrite == 1) begin
          paddr_r = apb_mon_pkt.paddr;
          pwdata_r = apb_mon_pkt.pwdata;
          prdata_r = apb_mon_pkt.prdata;
        end else begin
        end
        wait(timer_mon_pkt_q.size() > 0);
        timer_mon_pkt = timer_mon_pkt_q.pop_front();
	timer_cov_trans= timer_mon_pkt;
	cov.sample();
        // when should int be asserted?
        if(int_flag???)
          ref_value=1;
        else
          ref_value=0;
        compare(ref_value, timer_mon_pkt.timerint);
      end
    endtask

      function void scb::compare(logic ref_value, logic timerint);
      // check
        if(timerint!=ref_value)
        `uvm_error("SCBD", $sformatf("ERROR! ref_value=%0d, but timerint=%0d", ref_value, timerint))
      else
        `uvm_info("SCBD", $sformatf("PASS! ref_value=%d, timerint=%d", ref_value, timerint), UVM_HIGH)
    endfunction
