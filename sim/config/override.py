# empty for now
if test_is_a_file and (test_dir == "../riscv-tests/isa/rv32ui"):
    if verbosity >0:
        print "-I- From override.py : test {} is a file".format(test)
        print "-I- From override.py : test_name {} ".format(test_name)
        print "-I- From override.py : test_dir <{}> ".format(test_dir)
    cfg['c_compiler']['extra_c_sources'] = "$(TEST_DIR)/" + test_name + ".S"
    cfg['c_compiler']['extra_incdirs'] = " -I$(TOP)/common/include "
    cfg['c_compiler']['extra_defines'] = " -DTEST_FUNC_NAME={} ".format(test_name)
    cfg['c_compiler']['extra_defines'] += " -DTEST_FUNC_RET={}_ret ".format(test_name)
    cfg['c_compiler']['extra_defines'] += " -DTEST_FUNC_TXT='\"{}\"' ".format(test_name)
    # We override the warnings
    cfg['c_compiler']['warnings'] = "-Werror -Wall "

# Opus codec on Nanorv32
if test_dir == "../../opus":
        cfg['c_compiler']['extra_c_sources'] = "$(TEST_DIR)/" + ""
