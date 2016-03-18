/* 
	File : core_portme.c
*/
/*
	Author : Shay Gal-On, EEMBC
	Modified: Rolf Ambuhl, Nordic Semi
	Legal : TODO!
*/ 
#include <stdio.h>
#include <stdlib.h>
#include "coremark.h"
#include "core_portme.h"
#include <stdint.h>

//#include "zscale.h"
#define DRAM_ADDR 0x20000000
#define LED_ADDR  0xF0000000

#define DRAM_SIZE 64*1024*1024 // 64 MB

#if VALIDATION_RUN
	volatile ee_s32 seed1_volatile=0x3415;
	volatile ee_s32 seed2_volatile=0x3415;
	volatile ee_s32 seed3_volatile=0x66;
#endif
#if PERFORMANCE_RUN
	volatile ee_s32 seed1_volatile=0x0;
  
	volatile ee_s32 seed2_volatile=0x0;
	volatile ee_s32 seed3_volatile=0x66;
#endif
#if PROFILE_RUN
	volatile ee_s32 seed1_volatile=0x8;
	volatile ee_s32 seed2_volatile=0x8;
	volatile ee_s32 seed3_volatile=0x8;
#endif
	volatile ee_s32 seed4_volatile=ITERATIONS;
	volatile ee_s32 seed5_volatile=0;
/* Porting : Timing functions
	How to capture time and convert to seconds must be ported to whatever is supported by the platform.
	e.g. Read value from on board RTC, read value from cpu clock cycles performance counter etc. 
	Sample implementation for standard time.h and windows.h definitions included.
*/
/* Define : TIMER_RES_DIVIDER
	Divider to trade off timer resolution and total time that can be measured.

	Use lower values to increase resolution, but make sure that overflow does not occur.
	If there are issues with the return value overflowing, increase this value.
	*/
//#define NSECS_PER_SEC CLOCKS_PER_SEC
#define NSECS_PER_SEC  16000000
#define CORETIMETYPE clock_t 
#define GETMYTIME(_t) (*_t=clock())
#define MYTIMEDIFF(fin,ini) ((fin)-(ini))
#define TIMER_RES_DIVIDER 1
#define SAMPLE_TIME_IMPLEMENTATION 1
#define EE_TICKS_PER_SEC 10000000

/** Define Host specific (POSIX), or target specific global time variables. */
//volatile static CORETIMETYPE start_time_val,stop_time_val;

void led_set(int output)
{
  *(volatile int*)LED_ADDR = output;
}


/* Function : start_time
	This function will be called right before starting the timed portion of the benchmark.

	Implementation may be capturing a system timer (as implemented in the example code) 
	or zeroing some system parameters - e.g. setting the cpu clocks cycles to 0.
*/
long time2()
{
	int cycles;
	asm("rdcycle %0" : "=r"(cycles));
	// printf("[time() -> %d]", cycles);
	return cycles;
}
void start_time(void) {
  led_set(0x1);
}
/* Function : stop_time
	This function will be called right after ending the timed portion of the benchmark.

	Implementation may be capturing a system timer (as implemented in the example code) 
	or other system parameters - e.g. reading the current value of cpu cycles counter.
*/

void stop_time(void) {
	led_set(0x2);
}
/* Function : get_time
	Return an abstract "ticks" number that signifies time on the system.
	
	Actual value returned may be cpu cycles, milliseconds or any other value,
	as long as it can be converted to seconds by <time_in_secs>.
	This methodology is taken to accomodate any hardware or simulated platform.
	The sample implementation returns millisecs by default, 
	and the resolution is controlled by <TIMER_RES_DIVIDER>
*/
CORE_TICKS get_time(void) {
	//CORE_TICKS elapsed=(CORE_TICKS)(MYTIMEDIFF(stop_time_val, start_time_val));

//return elapsed;
  return 0;
}
/* Function : time_in_secs
	Convert the value returned by get_time to seconds.

	The <secs_ret> type is used to accomodate systems with no support for floating point.
	Default implementation implemented by the EE_TICKS_PER_SEC macro above.
*/
secs_ret time_in_secs(CORE_TICKS ticks) {
	secs_ret retval=((secs_ret)ticks) / (secs_ret)EE_TICKS_PER_SEC;
	return retval;
}

ee_u32 default_num_contexts = 1;

/* Function : portable_init
	Target specific initialization code 
	Test for some common mistakes.
*/


#include <string.h>
void portable_init(core_portable *p, int *argc, char *argv[])
{

	led_set(0xAAAA);

}
/* Function : portable_fini
	Target specific final code 
*/
void portable_fini(core_portable *p)
{
	p->portable_id=0;
}





