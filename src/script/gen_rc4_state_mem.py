# Python code for generating the Verilog code in the rc4 state mem.

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

