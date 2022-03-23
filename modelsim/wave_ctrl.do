onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_ma/in1
add wave -noupdate /tb_ma/in2
add wave -noupdate /tb_ma/out
add wave -noupdate /tb_ma/out_golden
add wave -noupdate -radix unsigned /tb_ma/_p
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {465600 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
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
WaveRestoreZoom {399300 ps} {526400 ps}
