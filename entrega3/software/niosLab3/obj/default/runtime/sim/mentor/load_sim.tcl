# ------------------------------------------------------------------------------
# Top Level Simulation Script to source msim_setup.tcl
# ------------------------------------------------------------------------------
set QSYS_SIMDIR obj/default/runtime/sim
source msim_setup.tcl
# Copy generated memory initialization hex and dat file(s) to current directory
file copy -force /home/leo/Desktop/Soc/Tutorial3/software/niosLab3/mem_init/hdl_sim/niosLab2_onchip_memory2_0.dat ./ 
file copy -force /home/leo/Desktop/Soc/Tutorial3/software/niosLab3/mem_init/niosLab2_onchip_memory2_0.hex ./ 
