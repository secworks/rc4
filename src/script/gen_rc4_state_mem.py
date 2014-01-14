#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#=======================================================================
#
# gen_rc4_state_mem.py
# --------------------
# Python code for generating the Verilog code in the rc4 state mem.
#
# Author: Joachim Strömbergson
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
#=======================================================================

# Register definitions.
for i in range(256):
    print("  reg [7 : 0] s0x%02x_reg;" % i)
    print("  reg [7 : 0] s0x%02x_new;" % i)
    print("  reg         s0x%02x_we;" % i)
    print("")

# Reg resets. Note 
for i in range(256):
    print("  s0x%02x_reg <= 8'h%02x;" % (i, i))


# Reg updates.
for i in range(256):
    print("          if (s0x%02x_we)" % i)
    print("            begin")
    print("              s0x%02x_reg <= s0x%02x_new;" % (i, i))
    print("            end")
    print("")


# Key mux. (Not really for state mem.)
for i in range(256):
    print("        0x%02x:" % i)
    print("          begin")
    print("            tmp_key_data = 0x%02x;" % i)
    print("          end")
    print("")



#=======================================================================
# gen_rc4_state_mem.py
#=======================================================================
