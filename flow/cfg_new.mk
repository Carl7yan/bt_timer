export TB_TOP_NAME = tb
export RTL_TOP_MODULE = cmsdk_apb_timer
export GITHUB = ~/work/1.github_carl7yan
export PROJECT  = ${GITHUB}/bt_timer
testname  =
fsdb      = on
random    =
uvm_verbo = UVM_MEDIUM
CM_LIST   =
RTL_LIST  = -f ${PROJECT}/filelist/rtl_list.f
TB_LIST   = -f ${PROJECT}/filelist/tb_list.f
REGR_LIST = ${PROJECT}/filelist/regr_list
FILELIST  = ${CM_LIST} ${RTL_LIST} ${TB_LIST}
TESTNAMES = `cat ${REGR_LIST}`
