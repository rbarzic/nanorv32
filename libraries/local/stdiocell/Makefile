# Makefile to create a .lib file for stdiocell (with multiple cells)
TOP?=../../..
CELL?=stdiocell

PROTOTOOLS?=$(TOP)/support/imported/prototools

LIB_GEN?=$(PROTOTOOLS)/anaspec2lib_multiple.py
SPEC?=./spec/spec.py

LIB_FILE=./lib/$(CELL).lib
LEF_FILE=./lef/$(CELL).lef

lib:
	$(LIB_GEN) -v --lib $(LIB_FILE)  $(SPEC) 

# LEF was manually generated
#lef:
#	$(LEF_GEN) -v --lef $(LEF_FILE)  $(SPEC) 

all: lib

.PHONY: lef lib
