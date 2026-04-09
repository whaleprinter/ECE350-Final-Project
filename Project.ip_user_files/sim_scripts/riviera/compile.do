transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

vlib work
vlib riviera/xpm
vlib riviera/xil_defaultlib

vmap xpm riviera/xpm
vmap xil_defaultlib riviera/xil_defaultlib

vlog -work xpm  -incr "+incdir+../../../../../../../../../Xilinx/2025.1/Vivado/data/rsb/busdef" "+incdir+../../ipstatic" -l xpm -l xil_defaultlib \
"C:/Xilinx/2025.1/Vivado/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \

vcom -work xpm -93  -incr \
"C:/Xilinx/2025.1/Vivado/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib  -incr -v2k5 "+incdir+../../../../../../../../../Xilinx/2025.1/Vivado/data/rsb/busdef" "+incdir+../../ipstatic" -l xpm -l xil_defaultlib \
"../../../Project.srcs/sources_1/imports/proc/alu.v" \
"../../../Project.srcs/sources_1/imports/proc/anandgate.v" \
"../../../Project.srcs/sources_1/imports/proc/annotb.v" \
"../../../Project.srcs/sources_1/imports/proc/anorgate.v" \
"../../../Project.srcs/sources_1/imports/proc/cla8bit.v" \
"../../../Project.srcs/sources_1/imports/proc/counter.v" \
"../../../Project.srcs/sources_1/imports/proc/dffe_ref.v" \
"../../../Project.srcs/sources_1/imports/proc/mux2.v" \
"../../../Project.srcs/sources_1/imports/proc/mux2onebit.v" \
"../../../Project.srcs/sources_1/imports/proc/mux4.v" \
"../../../Project.srcs/sources_1/imports/proc/mux8.v" \
"../../../Project.srcs/sources_1/imports/proc/sixtyfourbit_reg.v" \
"../../../Project.srcs/sources_1/imports/proc/sixtysixbit_reg.v" \
"../../../Project.srcs/sources_1/imports/proc/sll.v" \
"../../../Project.srcs/sources_1/imports/proc/sra.v" \
"../../../Project.srcs/sources_1/imports/proc/tffe.v" \
"../../../Project.srcs/sources_1/imports/proc/multdiv.v" \

vlog -work xil_defaultlib \
"glbl.v"

