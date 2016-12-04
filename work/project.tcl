set projDir "/home/ong/mojo/master/work/planAhead"
set projName "master"
set topName top
set device xc6slx9-2tqg144
if {[file exists "$projDir/$projName"]} { file delete -force "$projDir/$projName" }
create_project $projName "$projDir/$projName" -part $device
set_property design_mode RTL [get_filesets sources_1]
set verilogSources [list "/home/ong/mojo/master/work/verilog/mojo_top_0.v" "/home/ong/mojo/master/work/verilog/reset_conditioner_1.v" "/home/ong/mojo/master/work/verilog/counter_2.v" "/home/ong/mojo/master/work/verilog/edge_detector_3.v" "/home/ong/mojo/master/work/verilog/button_conditioner_4.v" "/home/ong/mojo/master/work/verilog/pipeline_5.v"]
import_files -fileset [get_filesets sources_1] -force -norecurse $verilogSources
set ucfSources [list "/home/ong/mojo/master/constraint/button.ucf" "/home/ong/Downloads/mojo-ide-B1.3.4/library/components/mojo.ucf"]
import_files -fileset [get_filesets constrs_1] -force -norecurse $ucfSources
set_property -name {steps.bitgen.args.More Options} -value {-g Binary:Yes -g Compress} -objects [get_runs impl_1]
set_property steps.map.args.mt on [get_runs impl_1]
set_property steps.map.args.pr b [get_runs impl_1]
set_property steps.par.args.mt on [get_runs impl_1]
update_compile_order -fileset sources_1
launch_runs -runs synth_1
wait_on_run synth_1
launch_runs -runs impl_1
wait_on_run impl_1
launch_runs impl_1 -to_step Bitgen
wait_on_run impl_1
