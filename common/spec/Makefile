TOP:=$(shell cd ../..; pwd)

EXTRACT=$(TOP)/common/scripts/sts_extract.pl
INSERT=$(TOP)/common/scripts/sts_insert.pl

GENERATED=$(TOP)/generated

FILES_WITH_GEN_CODE += $(TOP)/rtl/cores/nanorv32_parameters.v
FILES_WITH_GEN_CODE += $(TOP)/rtl/cores/nanorv32.v
# FILES_WITH_GEN_CODE += $(TOP)/hdl/sync/j2_core.v


gen_files:
	python nanorv32_gen.py

extract:
	$(foreach FILE, $(FILES_WITH_GEN_CODE), $(EXTRACT) --output_dir=$(GENERATED) $(FILE); )

insert:
	$(foreach FILE, $(FILES_WITH_GEN_CODE), $(INSERT) --input_dir=$(GENERATED) $(FILE); )
