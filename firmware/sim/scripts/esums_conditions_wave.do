onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /esums_conditions_tb/lhc_clk
add wave -noupdate -radix hexadecimal /esums_conditions_tb/data_i
add wave -noupdate /esums_conditions_tb/dut/comp_o
add wave -noupdate /esums_conditions_tb/dut/condition_o
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {9200 ps} 0}
configure wave -namecolwidth 329
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {584512 ps}
