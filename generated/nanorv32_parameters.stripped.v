//****************************************************************************/
//  Nanorv32 CPU
//  RTL IMPLEMENTATION, Synchronous Version
//
//  Copyright (C) yyyy  Ronan Barzic - rbarzic@gmail.com
//  Date            :  Tue Jan 19 21:01:45 2016
//
//  This program is free software; you can redistribute it and/or
//  modify it under the terms of the GNU General Public License
//  as published by the Free Software Foundation; either version 2
//  of the License, or (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program; if not, write to the Free Software
//  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,MA 02110-1301,USA.
//
//
//  Filename        :  nanorv32_parameters.v
//
//  Description     :  Parameter file for the nanorv32 core
//
//
//
//****************************************************************************/



parameter NANORV32_ADDR_SIZE=16; // 64K
parameter NANORV32_ADDR_MSB = NANORV32_ADDR_SIZE-1;

parameter NANORV32_DATA_SIZE=32;
parameter NANORV32_DATA_MSB = NANORV32_DATA_SIZE-1;

// 32-bit instruction only for now
parameter NANORV32_INSTRUCTION_SIZE = 32;
parameter NANORV32_INSTRUCTION_MSB = NANORV32_INSTRUCTION_SIZE -1;


parameter NANORV32_PERIPH_ADDR_SIZE=16; // 64K
parameter NANORV32_PERIPH_ADDR_MSB = NANORV32_PERIPH_ADDR_SIZE-1;


// Regidter file selector size
// 32 registers
parameter NANORV32_RF_PORTA_SIZE = 5;
parameter NANORV32_RF_PORTA_MSB = NANORV32_RF_PORTA_SIZE-1;
parameter NANORV32_RF_PORTB_SIZE = 5;
parameter NANORV32_RF_PORTB_MSB = NANORV32_RF_PORTB_SIZE-1;
parameter NANORV32_RF_PORTRD_SIZE = 5;
parameter NANORV32_RF_PORTRD_MSB = NANORV32_RF_PORTRD_SIZE-1;



//@begin[instruction_format]
//@end[instruction_format]

//@begin[inst_decode_definitions]
//@end[inst_decode_definitions]

//@begin[mux_select_definitions]
//@end[mux_select_definitions]

//@begin[micro_rom_param]
//@end[micro_rom_param]


// For the ALU shift amount (inputed on ALU port B)
parameter NANORV32_SHAMT_FILL = NANORV32_DATA_SIZE-NANORV32_INST_FORMAT_SHAMT_SIZE;



// state machine for the "pipeline" (fetch + executuion stages)

parameter NANORV32_PSTATE_BITS = 4;
parameter NANORV32_PSTATE_MSB = NANORV32_PSTATE_BITS - 1;

parameter NANORV32_PSTATE_RESET=0;
parameter NANORV32_PSTATE_CONT=1;
parameter NANORV32_PSTATE_BRANCH=2;
parameter NANORV32_PSTATE_WAITLD=3;
parameter NANORV32_PSTATE_IRQ_BEGIN=4;
parameter NANORV32_PSTATE_RETI_BEGIN=5;
parameter NANORV32_PSTATE_IRQ_CONT=6;
parameter NANORV32_PSTATE_RETI_CONT=7;
parameter NANORV32_PSTATE_IRQ_END=8;
parameter NANORV32_PSTATE_RETI_END=9;


// "jump to address 0" (reset value for instruction register)
parameter NANORV32_J0_INSTRUCTION = 32'b00000000_00000000_00000000_01101111;



parameter NANORV32_CODE_BASE_ADDRESS = 32'h00000000;
parameter NANORV32_RAM_BASE_ADDRESS = 32'h20000000;
parameter NANORV32_PERIPH_BASE_ADDRESS = 32'hF0000000;


// Micro-rom related parameters
parameter NANORV32_UROM_ADDR_BITS=6;
parameter NANORV32_UROM_ADDR_MSB=NANORV32_UROM_ADDR_BITS-1;


// "Ret" instruction as generated for GCC
// 000000000000  00001 000 00000 1100111
//   imm       x1/ra  -    x0    JALR
parameter NANORV32_RET_INSTRUCTION = 32'h00008067;
parameter NANORV32_X1_RA_RETI_MAGIC_VALUE = 32'hFFFFFFFF;
