# bt_timer  # bt is short for Block Test
apb-timer verification based on UVM

This project is still not complete and has bugs, be careful ...

only compile and simulate:
  - cd ./flow
  - modifiy cfg_new.mk
    - change 'GITHUB' to your full project path
  - make -f Makefile_new testname=apb_wr_test prep    # or other test name: apb_rd_test, apb_wr_test, timer_wr_extin0_test, timer_wr_extin1_test
  - make -f Makefile_new testname=apb_wr_test comp    # vcs compile
  - make -f Makefile_new testname=apb_wr_test sim     # simulate
  - make -f Makefile_new testname=apb_wr_test vd      # verdi waveform
  - make -f Makefile_new testname=apb_wr_test cov     # verdi coverage
  - make -f Makefile_new regr                         # run regression


if you want to add more cases:
  - add cases in ./bt/tc/                             # you can extend from base_test
  - add your case file in ./filelist/tb_list.f
  - add your case name in ./filelist/regr_list.f      # in case you want to run regression


reference uvm testbenches:
det_1011 ->  https://www.chipverify.com/uvm/uvm-verification-testbench-example
mem -> https://verificationguide.com/uvm/uvm-testbench-architecture/
