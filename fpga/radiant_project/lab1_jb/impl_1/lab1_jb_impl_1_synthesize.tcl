if {[catch {

# define run engine funtion
source [file join {C:/lscc/radiant/2024.1} scripts tcl flow run_engine.tcl]
# define global variables
global para
set para(gui_mode) "1"
set para(prj_dir) "C:/Users/jbowman/Desktop/microP-lab1/fpga/radiant_project/lab1_jb"
# synthesize IPs
# synthesize VMs
# synthesize top design
::radiant::runengine::run_postsyn [list -a iCE40UP -p iCE40UP5K -t SG48 -sp High-Performance_1.2V -oc Industrial -top -w -o lab1_jb_impl_1_syn.udb lab1_jb_impl_1.vm] [list C:/Users/jbowman/Desktop/microP-lab1/fpga/radiant_project/lab1_jb/impl_1/lab1_jb_impl_1.ldc]

} out]} {
   ::radiant::runengine::runtime_log $out
   exit 1
}
