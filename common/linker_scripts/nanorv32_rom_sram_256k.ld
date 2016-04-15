MEMORY
{
ROM (rx)   : ORIGIN = 0x0,        LENGTH = 0x40000  /* 256K */
RAM (rwx)  : ORIGIN = 0x20000000, LENGTH = 0x40000 /* 256K */
}

INCLUDE "sections.ld"
