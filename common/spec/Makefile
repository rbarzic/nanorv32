TOP:=$(shell cd ../..; pwd)

EXTRACT=$(TOP)/common/scripts/sts_extract.pl
INSERT=$(TOP)/common/scripts/sts_insert.pl

GENERATED=$(TOP)/generated

FILES_WITH_GEN_CODE += $(TOP)/rtl/cores/nanorv32_parameters.v
FILES_WITH_GEN_CODE += $(TOP)/rtl/cores/nanorv32.v
FILES_WITH_GEN_CODE += $(TOP)/rtl/cores/nanorv32_urom.v
FILES_WITH_GEN_CODE += $(TOP)/rtl/cores/nanorv32_decoder.v
# FILES_WITH_GEN_CODE += $(TOP)/hdl/sync/j2_core.v


gen_files:
	python nanorv32_gen.py

extract:
	$(foreach FILE, $(FILES_WITH_GEN_CODE), $(EXTRACT) --output_dir=$(GENERATED) $(FILE); )

insert:
	$(foreach FILE, $(FILES_WITH_GEN_CODE), $(INSERT) --input_dir=$(GENERATED) $(FILE); )

emacs_auto:
	emacs --batch   $(TOP)/rtl/cores/nanorv32_decoder.v -f verilog-batch-auto

# AHB Multilayer interconnect
# Note : sbt must be in the PATH
ahbmli:
	make -C $(TOP)/ml-ahb-gen all JSON=$(TOP)/common/spec/nanorv32_ahbmli.json
	cp $(TOP)/ml-ahb-gen/chisel/Ahbmli.v $(TOP)/rtl/ips
