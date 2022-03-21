onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /tb_ctrl/clk
add wave -noupdate -radix unsigned /tb_ctrl/rstn
add wave -noupdate -radix unsigned /tb_ctrl/start
add wave -noupdate -radix unsigned /tb_ctrl/cur_state
add wave -noupdate -radix unsigned /tb_ctrl/ctrl1/flag_fin
add wave -noupdate -divider index
add wave -noupdate -radix unsigned /tb_ctrl/p
add wave -noupdate -radix unsigned /tb_ctrl/k
add wave -noupdate -radix unsigned /tb_ctrl/i
add wave -noupdate -radix unsigned /tb_ctrl/gamma0
add wave -noupdate -radix unsigned /tb_ctrl/gamma1
add wave -noupdate -radix unsigned /tb_ctrl/ren
add wave -noupdate -radix unsigned /tb_ctrl/wen
add wave -noupdate /tb_ctrl/special_add
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {394500 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 208
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
WaveRestoreZoom {0 ps} {1150500 ps}
