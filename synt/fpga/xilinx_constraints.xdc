# clock signal
set_property -dict { PACKAGE_PIN E3    IOSTANDARD LVCMOS33 } [get_ports { XTAL1 }]; #IO_L12P_T1_MRCC_35 Sch=gclk[100]
create_clock -add -name xtal1  -period 10.00 -waveform {0 5} [get_ports {XTAL1}];

#Switches

#set_property -dict { PACKAGE_PIN A8    IOSTANDARD LVCMOS33 } [get_ports { SW[0] }]; #IO_L12N_T1_MRCC_16 Sch=sw[0]
#set_property -dict { PACKAGE_PIN C11   IOSTANDARD LVCMOS33 } [get_ports { SW[1] }]; #IO_L13P_T2_MRCC_16 Sch=sw[1]
#set_property -dict { PACKAGE_PIN C10   IOSTANDARD LVCMOS33 } [get_ports { SW[2] }]; #IO_L13N_T2_MRCC_16 Sch=sw[2]
#set_property -dict { PACKAGE_PIN A10   IOSTANDARD LVCMOS33 } [get_ports { SW[3] }]; #IO_L14P_T2_SRCC_16 Sch=sw[3]

#Switches

set_property -dict { PACKAGE_PIN A8    IOSTANDARD LVCMOS33 } [get_ports { NRST }]; #IO_L12N_T1_MRCC_16 Sch=sw[0]
#set_property -dict { PACKAGE_PIN C11   IOSTANDARD LVCMOS33 } [get_ports { SW[1] }]; #IO_L13P_T2_MRCC_16 Sch=sw[1]
#set_property -dict { PACKAGE_PIN C10   IOSTANDARD LVCMOS33 } [get_ports { SW[2] }]; #IO_L13N_T2_MRCC_16 Sch=sw[2]
#set_property -dict { PACKAGE_PIN A10   IOSTANDARD LVCMOS33 } [get_ports { SW[3] }]; #IO_L14P_T2_SRCC_16 Sch=sw[3]



# LEDs
# ARTY assignement
# set_property -dict { PACKAGE_PIN E1    IOSTANDARD LVCMOS33 } [get_ports { RGB0_Blue }]; #IO_L18N_T2_35 Sch=led0_b
# set_property -dict { PACKAGE_PIN F6    IOSTANDARD LVCMOS33 } [get_ports { RGB0_Green }]; #IO_L19N_T3_VREF_35 Sch=led0_g
# set_property -dict { PACKAGE_PIN G6    IOSTANDARD LVCMOS33 } [get_ports { RGB0_Red }]; #IO_L19P_T3_35 Sch=led0_r
# set_property -dict { PACKAGE_PIN G4    IOSTANDARD LVCMOS33 } [get_ports { RGB1_Blue }]; #IO_L20P_T3_35 Sch=led1_b
# set_property -dict { PACKAGE_PIN J4    IOSTANDARD LVCMOS33 } [get_ports { RGB1_Green }]; #IO_L21P_T3_DQS_35 Sch=led1_g
# set_property -dict { PACKAGE_PIN G3    IOSTANDARD LVCMOS33 } [get_ports { RGB1_Red }]; #IO_L20N_T3_35 Sch=led1_r
# set_property -dict { PACKAGE_PIN H4    IOSTANDARD LVCMOS33 } [get_ports { RGB2_Blue }]; #IO_L21N_T3_DQS_35 Sch=led2_b
# set_property -dict { PACKAGE_PIN J2    IOSTANDARD LVCMOS33 } [get_ports { RGB2_Green }]; #IO_L22N_T3_35 Sch=led2_g
# set_property -dict { PACKAGE_PIN J3    IOSTANDARD LVCMOS33 } [get_ports { RGB2_Red }]; #IO_L22P_T3_35 Sch=led2_r
# set_property -dict { PACKAGE_PIN K2    IOSTANDARD LVCMOS33 } [get_ports { RGB3_Blue }]; #IO_L23P_T3_35 Sch=led3_b
# set_property -dict { PACKAGE_PIN H6    IOSTANDARD LVCMOS33 } [get_ports { RGB3_Green }]; #IO_L24P_T3_35 Sch=led3_g
# set_property -dict { PACKAGE_PIN K1    IOSTANDARD LVCMOS33 } [get_ports { RGB3_Red }]; #IO_L23N_T3_35 Sch=led3_r
# set_property -dict { PACKAGE_PIN H5    IOSTANDARD LVCMOS33 } [get_ports { LED[0] }]; #IO_L24N_T3_35 Sch=led[4]
# set_property -dict { PACKAGE_PIN J5    IOSTANDARD LVCMOS33 } [get_ports { LED[1] }]; #IO_25_35 Sch=led[5]
# set_property -dict { PACKAGE_PIN T9    IOSTANDARD LVCMOS33 } [get_ports { LED[2] }]; #IO_L24P_T3_A01_D17_14 Sch=led[6]
# set_property -dict { PACKAGE_PIN T10   IOSTANDARD LVCMOS33 } [get_ports { LED[3] }]; #IO_L24N_T3_A00_D16_14 Sch=led[7]

# LEDs

set_property -dict { PACKAGE_PIN H5    IOSTANDARD LVCMOS33 } [get_ports { P0[0] }]; #IO_L24N_T3_35 Sch=led[4]
set_property -dict { PACKAGE_PIN J5    IOSTANDARD LVCMOS33 } [get_ports { P0[1] }]; #IO_25_35 Sch=led[5]
set_property -dict { PACKAGE_PIN T9    IOSTANDARD LVCMOS33 } [get_ports { P0[2] }]; #IO_L24P_T3_A01_D17_14 Sch=led[6]
set_property -dict { PACKAGE_PIN T10   IOSTANDARD LVCMOS33 } [get_ports { P0[3] }]; #IO_L24N_T3_A00_D16_14 Sch=led[7]

set_property -dict { PACKAGE_PIN E1    IOSTANDARD LVCMOS33 } [get_ports { P0[4] }]; #IO_L18N_T2_35 Sch=led0_b
set_property -dict { PACKAGE_PIN F6    IOSTANDARD LVCMOS33 } [get_ports { P0[5] }]; #IO_L19N_T3_VREF_35 Sch=led0_g
set_property -dict { PACKAGE_PIN G6    IOSTANDARD LVCMOS33 } [get_ports { P0[6] }]; #IO_L19P_T3_35 Sch=led0_r
set_property -dict { PACKAGE_PIN G4    IOSTANDARD LVCMOS33 } [get_ports { P0[7] }]; #IO_L20P_T3_35 Sch=led1_b
set_property -dict { PACKAGE_PIN J4    IOSTANDARD LVCMOS33 } [get_ports { P0[8] }]; #IO_L21P_T3_DQS_35 Sch=led1_g
set_property -dict { PACKAGE_PIN G3    IOSTANDARD LVCMOS33 } [get_ports { P0[9] }]; #IO_L20N_T3_35 Sch=led1_r
set_property -dict { PACKAGE_PIN H4    IOSTANDARD LVCMOS33 } [get_ports { P0[10] }]; #IO_L21N_T3_DQS_35 Sch=led2_b
set_property -dict { PACKAGE_PIN J2    IOSTANDARD LVCMOS33 } [get_ports { P0[11] }]; #IO_L22N_T3_35 Sch=led2_g
set_property -dict { PACKAGE_PIN J3    IOSTANDARD LVCMOS33 } [get_ports { P0[12] }]; #IO_L22P_T3_35 Sch=led2_r
set_property -dict { PACKAGE_PIN K2    IOSTANDARD LVCMOS33 } [get_ports { P0[13] }]; #IO_L23P_T3_35 Sch=led3_b
set_property -dict { PACKAGE_PIN H6    IOSTANDARD LVCMOS33 } [get_ports { P0[14] }]; #IO_L24P_T3_35 Sch=led3_g
set_property -dict { PACKAGE_PIN K1    IOSTANDARD LVCMOS33 } [get_ports { P0[15] }]; #IO_L23N_T3_35 Sch=led3_r


##Pmod Header JA

#set_property -dict { PACKAGE_PIN G13   IOSTANDARD LVCMOS33 } [get_ports { ja[1] }]; #IO_0_15 Sch=ja[1]
#set_property -dict { PACKAGE_PIN B11   IOSTANDARD LVCMOS33 } [get_ports { ja[2] }]; #IO_L4P_T0_15 Sch=ja[2]
#set_property -dict { PACKAGE_PIN A11   IOSTANDARD LVCMOS33 } [get_ports { ja[3] }]; #IO_L4N_T0_15 Sch=ja[3]
#set_property -dict { PACKAGE_PIN D12   IOSTANDARD LVCMOS33 } [get_ports { ja[4] }]; #IO_L6P_T0_15 Sch=ja[4]
#set_property -dict { PACKAGE_PIN D13   IOSTANDARD LVCMOS33 } [get_ports { ja[7] }]; #IO_L6N_T0_VREF_15 Sch=ja[7]
#set_property -dict { PACKAGE_PIN B18   IOSTANDARD LVCMOS33 } [get_ports { ja[8] }]; #IO_L10P_T1_AD11P_15 Sch=ja[8]
#set_property -dict { PACKAGE_PIN A18   IOSTANDARD LVCMOS33 } [get_ports { ja[9] }]; #IO_L10N_T1_AD11N_15 Sch=ja[9]
#set_property -dict { PACKAGE_PIN E15   IOSTANDARD LVCMOS33 } [get_ports { ja[10] }]; #IO_L11P_T1_SRCC_15 Sch=ja[10]

set_property -dict { PACKAGE_PIN G13   IOSTANDARD LVCMOS33 } [get_ports { P1[0] }]; #IO_0_15 Sch=ja[1]
set_property -dict { PACKAGE_PIN B11   IOSTANDARD LVCMOS33 } [get_ports { P1[1] }]; #IO_L4P_T0_15 Sch=ja[2]
set_property -dict { PACKAGE_PIN A11   IOSTANDARD LVCMOS33 } [get_ports { P1[2] }]; #IO_L4N_T0_15 Sch=ja[3]
set_property -dict { PACKAGE_PIN D12   IOSTANDARD LVCMOS33 } [get_ports { P1[3] }]; #IO_L6P_T0_15 Sch=ja[4]
set_property -dict { PACKAGE_PIN D13   IOSTANDARD LVCMOS33 } [get_ports { P1[4] }]; #IO_L6N_T0_VREF_15 Sch=ja[7]
set_property -dict { PACKAGE_PIN B18   IOSTANDARD LVCMOS33 } [get_ports { P1[5] }]; #IO_L10P_T1_AD11P_15 Sch=ja[8]
set_property -dict { PACKAGE_PIN A18   IOSTANDARD LVCMOS33 } [get_ports { P1[6] }]; #IO_L10N_T1_AD11N_15 Sch=ja[9]
set_property -dict { PACKAGE_PIN E15   IOSTANDARD LVCMOS33 } [get_ports { P1[7] }]; #IO_L11P_T1_SRCC_15 Sch=ja[10]



##Pmod Header JB

set_property -dict { PACKAGE_PIN D15   IOSTANDARD LVCMOS33 } [get_ports { P1[8] }]; #IO_L12P_T1_MRCC_15 Sch=jb[1]
set_property -dict { PACKAGE_PIN C15   IOSTANDARD LVCMOS33 } [get_ports { P1[9] }]; #IO_L12N_T1_MRCC_15 Sch=jb[2]
set_property -dict { PACKAGE_PIN F18   IOSTANDARD LVCMOS33 } [get_ports { P1[10] }]; #IO_L22N_T3_A16_15 Sch=jb[3]
set_property -dict { PACKAGE_PIN J17   IOSTANDARD LVCMOS33 } [get_ports { P1[11] }]; #IO_L23P_T3_FOE_B_15 Sch=jb[4]
set_property -dict { PACKAGE_PIN J18   IOSTANDARD LVCMOS33 } [get_ports { P1[12] }]; #IO_L23N_T3_FWE_B_15 Sch=jb[7]
set_property -dict { PACKAGE_PIN K15   IOSTANDARD LVCMOS33 } [get_ports { P1[13] }]; #IO_L24P_T3_RS1_15 Sch=jb[8]
set_property -dict { PACKAGE_PIN J15   IOSTANDARD LVCMOS33 } [get_ports { P1[14] }]; #IO_L24N_T3_RS0_15 Sch=jb[9]
set_property -dict { PACKAGE_PIN K16   IOSTANDARD LVCMOS33 } [get_ports { P1[15] }]; #IO_25_15 Sch=jb[10]

##Pmod Header JC

#set_property -dict { PACKAGE_PIN U12   IOSTANDARD LVCMOS33 } [get_ports { jc[1] }]; #IO_L20P_T3_A08_D24_14 Sch=jc[1]
#set_property -dict { PACKAGE_PIN V12   IOSTANDARD LVCMOS33 } [get_ports { jc[2] }]; #IO_L20N_T3_A07_D23_14 Sch=jc[2]
#set_property -dict { PACKAGE_PIN V10   IOSTANDARD LVCMOS33 } [get_ports { jc[3] }]; #IO_L21P_T3_DQS_14 Sch=jc[3]
#set_property -dict { PACKAGE_PIN V11   IOSTANDARD LVCMOS33 } [get_ports { jc[4] }]; #IO_L21N_T3_DQS_A06_D22_14 Sch=jc[4]
#set_property -dict { PACKAGE_PIN U14   IOSTANDARD LVCMOS33 } [get_ports { jc[7] }]; #IO_L22P_T3_A05_D21_14 Sch=jc[7]
#set_property -dict { PACKAGE_PIN V14   IOSTANDARD LVCMOS33 } [get_ports { jc[8] }]; #IO_L22N_T3_A04_D20_14 Sch=jc[8]
#set_property -dict { PACKAGE_PIN T13   IOSTANDARD LVCMOS33 } [get_ports { jc[9] }]; #IO_L23P_T3_A03_D19_14 Sch=jc[9]
#set_property -dict { PACKAGE_PIN U13   IOSTANDARD LVCMOS33 } [get_ports { jc[10] }]; #IO_L23N_T3_A02_D18_14 Sch=jc[10]


set_property -dict { PACKAGE_PIN U12   IOSTANDARD LVCMOS33 } [get_ports { nTRST }]; #IO_L20P_T3_A08_D24_14 Sch=jc[1]
set_property -dict { PACKAGE_PIN V12   IOSTANDARD LVCMOS33 } [get_ports { TDI }]; #IO_L20N_T3_A07_D23_14 Sch=jc[2]
set_property -dict { PACKAGE_PIN V10   IOSTANDARD LVCMOS33 } [get_ports { TDO }]; #IO_L21P_T3_DQS_14 Sch=jc[3]
set_property -dict { PACKAGE_PIN V11   IOSTANDARD LVCMOS33 } [get_ports { SWDIOTMS }]; #IO_L21N_T3_DQS_A06_D22_14 Sch=jc[4]
set_property -dict { PACKAGE_PIN U14   IOSTANDARD LVCMOS33 } [get_ports { SWCLKTCK }]; #IO_L22P_T3_A05_D21_14 Sch=jc[7]
set_property -dict { PACKAGE_PIN V14   IOSTANDARD LVCMOS33 } [get_ports { XTAL2 }]; #IO_L22N_T3_A04_D20_14 Sch=jc[8]
#set_property -dict { PACKAGE_PIN T13   IOSTANDARD LVCMOS33 } [get_ports { jc[9] }]; #IO_L23P_T3_A03_D19_14 Sch=jc[9]
#set_property -dict { PACKAGE_PIN U13   IOSTANDARD LVCMOS33 } [get_ports { jc[10] }]; #IO_L23N_T3_A02_D18_14 Sch=jc[10]
