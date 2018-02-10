#===================================================================
#
# Makefile
# --------
# Makefile for building the rc4 core and top simulation.
#
#
# Author: Joachim Strombergson
# Copyright (c) 2013, Secworks Sweden AB
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or
# without modification, are permitted provided that the following
# conditions are met:
#
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
#
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in
#    the documentation and/or other materials provided with the
#    distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
# FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
# COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
# INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
# BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
# STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
# ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
#===================================================================

RC4_SRC=../src/rtl/rc4.v ../src/rtl/rc4_key_mem.v ../src/rtl/rc4_state_mem.v
RC4_TB_SRC=../src/tb/tb_rc4.v

CC=iverilog
LINT=verilator
LINTFLAGS =  --lint-only  -Wall -Wno-fatal -Wno-DECLFILENAME


all: rc4.sim


rc4.sim: $(RC4_TB_SRC) $(RC4_SRC)
	$(CC) -o rc4.sim $(RC4_TB_SRC) $(RC4_SRC)


sim-rc4: rc4.sim
	./rc4.sim


debug:
	@echo "No debug available."


lint:   $(RC4_SRC)
	$(LINT) $(LINTFLAGS) $(RC4_SRC)


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
