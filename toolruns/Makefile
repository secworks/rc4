#===================================================================
#
# Makefile
# --------
# Makefile for building the rc4 core and top simulation.
#
#
# (c) 2013 Joachim Strombergson
#
#===================================================================

RC4_SRC=../src/rtl/rc4.v ../src/rtl/rc4_key_mem.v ../src/rtl/rc4_state_mem.v
RC4_TB_SRC=../src/tb/tb_rc4.v

CC=iverilog


all: top


top: $(RC4_TB_SRC) $(RC4_SRC)
	$(CC) -o rc4.sim $(RC4_TB_SRC) $(RC4_SRC)


sim-rc4: rc4.sim
	./rc4.sim


debug:
	@echo "No debug available."


clean:
	rm -f rc4.sim


help:
	@echo "Supported targets:"
	@echo "------------------"
	@echo "top:      Build top level simulation target."
	@echo "sim-rc4:  Run rc4 top level simulation."
	@echo "debug:    Print the internal varibles."
	@echo "clean:    Delete all built files."

#===================================================================
# EOF Makefile
#===================================================================

