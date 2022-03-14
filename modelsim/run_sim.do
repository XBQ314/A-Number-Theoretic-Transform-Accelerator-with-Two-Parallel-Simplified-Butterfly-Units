vlog -O0 -vlog01compat -f flist.f
vsim -c +nowarnTSCALE -L ./work -novopt -l load.log tb_km_mm
radix dec
##add log -r /tb/*
do ./wave_km_mm.do
run -all