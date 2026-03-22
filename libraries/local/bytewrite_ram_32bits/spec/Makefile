TOP?=../../../../
CELL?=bytewrite_ram_32bits

LEF_GEN?=$(TOP)/support/imported/prototools/anaspec2lef.py
LIB_GEN?=$(TOP)/support/imported/prototools/anaspec2lib.py
SPEC?=./spec.py

LIB_FILE=../lib/$(CELL).lib
LEF_FILE=../lef/$(CELL).lef
LEF_DIR=../lef

lib:
	$(LIB_GEN) -v --lib $(LIB_FILE)  $(SPEC) 

lef:
	$(LEF_GEN) -v --lef $(LEF_DIR)/$(CELL)_m.lef  --metal_prefix m  $(SPEC) 
	$(LEF_GEN) -v --lef $(LEF_DIR)/$(CELL)_M.lef  --metal_prefix M  $(SPEC) 
	$(LEF_GEN) -v --lef $(LEF_DIR)/$(CELL)_Metal.lef  --metal_prefix Metal  $(SPEC) 
	$(LEF_GEN) -v --lef $(LEF_DIR)/$(CELL)_metal.lef  --metal_prefix metal  $(SPEC) 
	$(LEF_GEN) -v --lef $(LEF_DIR)/$(CELL)_met.lef  --metal_prefix met  $(SPEC) 
	$(LEF_GEN) -v --lef $(LEF_DIR)/$(CELL)_Met.lef  --metal_prefix Met  $(SPEC) 

all: lef lib
