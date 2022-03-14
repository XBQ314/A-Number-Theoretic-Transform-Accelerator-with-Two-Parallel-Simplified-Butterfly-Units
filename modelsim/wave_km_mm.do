onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_km_mm/clk
add wave -noupdate -radix unsigned /tb_km_mm/Mon_R
add wave -noupdate -radix unsigned /tb_km_mm/in1
add wave -noupdate -radix unsigned /tb_km_mm/in2
add wave -noupdate -radix unsigned /tb_km_mm/out
add wave -noupdate -radix unsigned /tb_km_mm/out_golden
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2263900 ps} 0}
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
WaveRestoreZoom {2213600 ps} {2370100 ps}
