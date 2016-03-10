#ifndef _ENV_PICORV32_TEST_H
#define _ENV_PICORV32_TEST_H

#ifndef TEST_FUNC_NAME
#  define TEST_FUNC_NAME mytest
#  define TEST_FUNC_TXT "mytest"
#  define TEST_FUNC_RET mytest_ret
#endif

#define RVTEST_RV32U
#define TESTNUM x28

#define RVTEST_CODE_BEGIN \
    .global main;\
main:\
     lui a0,0x5A5A5;                                 \



#define RVTEST_PASS \
    lui a0,0xCAFFE; \
    j exit;

#define RVTEST_FAIL \
    lui a0,0x0DEADD; \
    j exit;



#define RVTEST_CODE_END
#define RVTEST_DATA_BEGIN .balign 4;
#define RVTEST_DATA_END

#endif
