onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib arty_mmcm_opt

do {wave.do}

view wave
view structure
view signals

do {arty_mmcm.udo}

run -all

quit -force
