# Test harness for the APB IF generator

TOP:=$(shell cd ../..; pwd)

EXTRACT=$(TOP)/common/scripts/sts_extract.pl
INSERT=$(TOP)/common/scripts/sts_insert.pl

GENERATED=$(TOP)/generated

FILES_WITH_GEN_CODE += ./uart_params.v

gen_files:
	./busif.py --vif=uart_apbif.v --vparams=$(GENERATED)/uart_apbif_auto_params.generated.v

extract:
	$(foreach FILE, $(FILES_WITH_GEN_CODE), $(EXTRACT) --output_dir=$(GENERATED) $(FILE); )

insert:
	$(foreach FILE, $(FILES_WITH_GEN_CODE), $(INSERT) --input_dir=$(GENERATED) $(FILE); )

emacs_auto:
	emacs --batch   uart_apbif.v -f verilog-batch-auto



uart:
	./busif.py --vif=uart_apbif.v --vparams=uart_apbif_auto_params.generated.v
	emacs --batch  uart_apbif.v  -f verilog-batch-auto
