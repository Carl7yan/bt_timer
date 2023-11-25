# envir
.PHONY: compile tc_all vd cov cov_all

TOP := tb
SIM_LIST  := -f ./tb.lst
TIMESCALE := -timescale=1ns/1ps
TIME := $(shell date +"%Y%m%d%H%M%s")
SEED := ${TIME}


# TestCase Setting
TC 	   := $(basename $(notdir $(wildcard ./tc/*.sv)))
CASE_NAMES := $(sort ${TC})
CASE_NUM   := $(words ${TC})

# VCS Setting
CMP_CMD := vcs -cpp g++-4.8 -cc gcc-4.8 -LDFLAGS -Wl,--no-as-needed -lpthread
PLI_OPTIONS := ${VERDI_HOME}/share/PLI/VCS/LINUX64/novas.tab
PLI_OPTIONS += ${VERDI_HOME}/share/PLI/VCS/LINUX64/pli.a

CMP_OPTIONS := +vcs+lic+wait -full64 +v2k -sverilog
CMP_OPTIONS += -top ${TOP} ${SIM_LIST}
CMP_OPTIONS += -notice +nospecify -ntb_opts check
CMP_OPTIONS += -debug_access+all+dmptf -debug_region=cell+encrypt
CMP_OPTIONS += ${TIMESCALE} -P ${PLI_OPTIONS}
CMP_OPTIONS += -l comp.log

#Coverage Setting
CM 	:= -cm line+cond+fsm+branch+tgl -cm_cond allops -cm_line contassign
CM_NAME = -cm_name $@_${SEED}

compile:
	${CMP_CMD} ${CMP_OPTIONS} \
	${CM} ${CM_DIR}

tc_all:
	@echo ${CASE_NAMES}
	@echo Total ${CASE_NUM} cases
	-make ${CASE_NAMES}

$(TC):
	mkdir -p wave
	mkdir -p log
	make compile
	./simv +ntb_random_seed=${SEED} ${CM} ${CM_NAME} -l ./log/sim_$@_${SEED}.log
	mv ${TOP}.fsdb ./wave/$@_${SEED}.fsdb
	mv comp.log ./log/comp_$@_${SEED}.log

vd:
	verdi -sv -nologo -top ${TOP} ${SIM_LIST} -ssf ${TOP}.fsdb &

cov:
	dve -full64 -covdir simv.vdb &

cov_all:
	urg -dir simv.vdb -dbname merge.vdb
	dve -full64 -covdir merge.vdb &

clean:
	-rm -rf simv* verdiLog ucli* csrc novas* *.log *.vdb DVEfiles

clean_all:
	make clean
	rm -rf wave vdb_file log *.fsdb urgReport
