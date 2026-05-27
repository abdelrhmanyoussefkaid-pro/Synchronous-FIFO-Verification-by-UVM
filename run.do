vlib work
vlog -f src_files.list +cover -covercells
vsim -voptargs=+acc work.top -classdebug -uvmcontrol=all -cover
coverage save fifo.ucdb -onexit 
add wave /top/fifoif/*
run -all