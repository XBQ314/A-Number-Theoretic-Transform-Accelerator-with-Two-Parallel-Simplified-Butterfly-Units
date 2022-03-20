onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /tb_bfu_v0/clk
add wave -noupdate -radix unsigned /tb_bfu_v0/op
add wave -noupdate -radix unsigned /tb_bfu_v0/cnt
add wave -noupdate -radix unsigned /tb_bfu_v0/in1
add wave -noupdate -radix unsigned /tb_bfu_v0/in2
add wave -noupdate /tb_bfu_v0/gamma
add wave -noupdate -radix unsigned /tb_bfu_v0/out1
add wave -noupdate -radix unsigned /tb_bfu_v0/out1_golden
add wave -noupdate -radix unsigned /tb_bfu_v0/out2
add wave -noupdate -radix unsigned /tb_bfu_v0/out2_golden
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2172900 ps} 0}
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
WaveRestoreZoom {0 ps} {8449400 ps}
