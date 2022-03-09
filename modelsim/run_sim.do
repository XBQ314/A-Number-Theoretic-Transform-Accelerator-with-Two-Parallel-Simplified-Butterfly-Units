vlog -O0 -vlog01compat -f flist.f
vsim -c +nowarnTSCALE -L ./work -novopt -l load.log tb_ma
radix dec
##add log -r /tb/*
do ./wave_ma.do
run -all