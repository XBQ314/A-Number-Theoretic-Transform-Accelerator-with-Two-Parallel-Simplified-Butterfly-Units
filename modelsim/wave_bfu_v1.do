onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /tb_bfu_v1/clk
add wave -noupdate -radix unsigned /tb_bfu_v1/rstn
add wave -noupdate -radix unsigned /tb_bfu_v1/op
add wave -noupdate -radix unsigned /tb_bfu_v1/in1
add wave -noupdate -radix unsigned /tb_bfu_v1/in2
add wave -noupdate -radix unsigned /tb_bfu_v1/gamma
add wave -noupdate -radix unsigned /tb_bfu_v1/out1
add wave -noupdate -radix unsigned /tb_bfu_v1/out2
add wave -noupdate -radix unsigned /tb_bfu_v1/out1_golden
add wave -noupdate -radix unsigned /tb_bfu_v1/out2_golden
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {3200 ps} 0}
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
WaveRestoreZoom {0 ps} {9500 ps}
