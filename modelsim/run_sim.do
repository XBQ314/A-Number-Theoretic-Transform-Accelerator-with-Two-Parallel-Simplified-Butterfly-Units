vlog -O0 -vlog01compat -f flist.f
vsim -c +nowarnTSCALE -L ./work -novopt -l load.log tb_normal_mm
radix dec
##add log -r /tb/*
do ./wave_normal_mm.do
run -all