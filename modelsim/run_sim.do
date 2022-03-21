vlog -O0 -vlog01compat -f flist.f
vsim -c +nowarnTSCALE -L ./work -novopt -l load.log tb_ctrl
radix dec
##add log -r /tb/*
do ./wave_ctrl.do
run -all