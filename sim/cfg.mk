TOP_NAME := tb
RTL_LIST := -f ../filelist/rtl_list.f
TB_LIST  := -f ../filelist/tb_list.f
FILELIST := ${RTL_LIST} ${TB_LIST}

#####################################################3
# common design options
# verilator, iverilog, vcs, modelsim
COM_SIM_OPTS := vcs
# user define options +define+;+incdir+
COM_USR_OPTS :=

# CBB list file for common design
CBB_LIST :=
# simulate file list
SIM_LIST :=
# synthsis file list
SYN_LIST :=
# sdc
SDC_FILE := ${SVN_ROOT}/common/eda/ip_chk/cm.sdc
# sgdc
SGDC_FILE := ${SVN_ROOT}/common/eda/ip_chk/cm.sgdc
# target libary
TARGET_LIBRARY_FILES:=
# waiver file for spyglass
WAIVER_FILE :=

#Add memory and other hard macro db here
ADD_LINK_LIB := [list \
]

#ADD_LINK_LIB := [list \
#/xx/yy/zz.db \
#/xx/yy/aa.db \
#]

# file list group
OPTS_SIM_LIST := ${CMODE_LIST} ${CBB_LIST} ${SIM_LIST} ${RTL_LIST}
OPTS_CMP_LIST := ${CBB_LIST} ${SIM_LIST} ${RTL_LIST}
