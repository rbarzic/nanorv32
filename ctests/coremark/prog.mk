coremark_c_src = \
	core_main.c \
  core_list_join.c \
  core_matrix.c \
  core_portme.c \
  core_state.c \
  core_util.c \
	trap.c \

coremark_riscv_src = \
	crt.S \

coremark_c_objs     = $(patsubst %.c, %.o, $(coremark_c_src))
coremark_riscv_objs = $(patsubst %.S, %.o, $(coremark_riscv_src))

coremark_riscv_bin = coremark.riscv
$(coremark_riscv_bin) : $(coremark_c_objs) $(coremark_riscv_objs)
	$(RISCV_LINK) $(coremark_c_objs) $(coremark_riscv_objs) -o $(coremark_riscv_bin) $(RISCV_LINK_OPTS)

junk += $(coremark_c_objs) $(coremark_riscv_objs) $(coremark_host_bin) $(coremark_riscv_bin)
