vlog -O0 -vlog01compat -f flist.f
vsim -c +nowarnTSCALE -L ./work -novopt -l load.log tb_km
radix dec
##add log -r /tb/*
do ./wave_km.do
run -all