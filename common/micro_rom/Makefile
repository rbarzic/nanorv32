TOP:=$(shell cd ../..; pwd)

SRC=micro_rom.S
PROG=micro_rom
STARTUP_CODE=

include ../../common/makefile/gcc.mk
include ../../common/makefile/ccomp.mk

urom_code:
	./vmem2v.py --vmem32=micro_rom.vmem32 --map=micro_rom.map --outdir=$(TOP)/generated
