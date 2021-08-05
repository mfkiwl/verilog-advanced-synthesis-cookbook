
REPO_ROOT=`git rev-parse --show-toplevel`
#echo " In repo: $REPO_ROOT"

TOP=$1

VERILOG_SRC=$REPO_ROOT/src/rtl/arithmetic/adder/$TOP.v
TB_SRC=$REPO_ROOT/src/tb/arithmetic/adder/${TOP}_tb.sv

mkdir -p output
iverilog -g2005-sv $TB_SRC $VERILOG_SRC -o output/$TOP
./output/$TOP
