vlog -O0 -vlog01compat -f flist.f
vsim -c +nowarnTSCALE -L ./work -novopt -l load.log tb_bfu_v1
radix dec
##add log -r /tb/*
do ./wave_bfu_v1.do
run -all