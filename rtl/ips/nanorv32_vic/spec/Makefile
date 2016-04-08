TOP:=$(shell cd ../../../..; pwd)

EXTRACT=$(TOP)/common/scripts/sts_extract.pl
INSERT=$(TOP)/common/scripts/sts_insert.pl

GENERATED=$(TOP)/generated

IP=nanorv32_vic
V_FILE=../verilog/rtl/$(IP)_apbif.v

FILES_WITH_GEN_CODE += ../verilog/include/$(IP)_params.v

gen_files:
	$(TOP)/common/generators/busif.py --spec=./nanorv32_vic.py --vif=$(V_FILE) --vparams=$(GENERATED)/$(IP)_apbif_auto_params.generated.v

extract:
	$(foreach FILE, $(FILES_WITH_GEN_CODE), $(EXTRACT) --output_dir=$(GENERATED) $(FILE); )

insert:
	$(foreach FILE, $(FILES_WITH_GEN_CODE), $(INSERT) --input_dir=$(GENERATED) $(FILE); )

emacs_auto:
	emacs --batch   $(V_FILE) -f verilog-batch-auto
