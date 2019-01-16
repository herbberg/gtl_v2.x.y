
##***************************** Beginning of Script ***************************
        
## If MTI_LIBS is defined, map unisim and simprim directories using MTI_LIBS
## This mode of mapping the unisims libraries is provided for backward 
## compatibility with previous wizard releases. If you don't set MTI_LIBS
## the unisim libraries will be loaded from the paths set up by compxlib in
## your modelsim.ini file

set XILINX   $env(XILINX)
if [info exists env(MTI_LIBS)] {    
    set MTI_LIBS $env(MTI_LIBS)
    vlib UNISIM
    vlib SECUREIP
    vmap UNISIM $MTI_LIBS/unisim
    vmap SECUREIP $MTI_LIBS/secureip
  
}

## set your src files directory for your design
set GT_SRC ./../hdl

set TESTBENCH ./../sim/testbench

## Create and map work directory
vlib work
vmap work work

#Top Entity the design
vcom -93 -work work $GT_SRC/lhc_data_pkg.vhd
vcom -93 -work work $GT_SRC/gt_mp7_core/gt_mp7_core_pkg_sim.vhd
vcom -93 -work work $GT_SRC/math_pkg.vhd
vcom -93 -work work $GT_SRC/gt_mp7_core/gtl_fdl_wrapper/gtl/gtl_pkg_sim.vhd
vcom -93 -work work $GT_SRC/gt_mp7_core/gtl_fdl_wrapper/gtl/out_reg_mux.vhd
vcom -93 -work work $GT_SRC/gt_mp7_core/gtl_fdl_wrapper/gtl/combinatorial_and.vhd
vcom -93 -work work $GT_SRC/gt_mp7_core/gtl_fdl_wrapper/gtl/correlation_conditions.vhd

#Testbench
vcom -93 -work work $TESTBENCH/correlation_conditions_tb.vhd

#Load Design
vsim -t 1ps work.correlation_conditions_tb 

##Load signals in wave window
view wave
do $TESTBENCH/../scripts/correlation_conditions_wave.do

##Run simulation
run 280 ns

# eof



