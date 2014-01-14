//======================================================================
//
// rc4_state_mem.v
// ---------------
// Verilog 2001 implementation of the state memory for the RC4 
// stream cipher. The smem handles state byte swap internally.
//
//
// Copyright (c) 2013 Secworks Sweden AB
// All rights reserved.
// 
// Redistribution and use in source and binary forms, with or 
// without modification, are permitted provided that the following 
// conditions are met: 
// 
// 1. Redistributions of source code must retain the above copyright 
//    notice, this list of conditions and the following disclaimer. 
// 
// 2. Redistributions in binary form must reproduce the above copyright 
//    notice, this list of conditions and the following disclaimer in 
//    the documentation and/or other materials provided with the 
//    distribution. 
// 
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS 
// "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT 
// LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS 
// FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE 
// COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, 
// INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, 
// BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER 
// CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, 
// STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) 
// ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF 
// ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
//======================================================================

module rc4_state_mem(
                     input wire          clk,
                     input wire          reset_n,
                     
                     input wire          init,
                     input wire          swap,
                     
                     input wire  [7 : 0] i_read_addr,
                     output wire [7 : 0] i_read_data,
                     
                     input wire  [7 : 0] j_read_addr,
                     output wire [7 : 0] j_read_data,
                     
                     input wire  [7 : 0] k_read_addr,
                     output wire [7 : 0] k_read_data
                    );

  
  //----------------------------------------------------------------
  // Registers including update variables and write enable.
  //----------------------------------------------------------------
  reg [7 : 0] s0x00_reg;
  reg [7 : 0] s0x00_new;
  reg         s0x00_we;

  reg [7 : 0] s0x01_reg;
  reg [7 : 0] s0x01_new;
  reg         s0x01_we;

  reg [7 : 0] s0x02_reg;
  reg [7 : 0] s0x02_new;
  reg         s0x02_we;

  reg [7 : 0] s0x03_reg;
  reg [7 : 0] s0x03_new;
  reg         s0x03_we;

  reg [7 : 0] s0x04_reg;
  reg [7 : 0] s0x04_new;
  reg         s0x04_we;

  reg [7 : 0] s0x05_reg;
  reg [7 : 0] s0x05_new;
  reg         s0x05_we;

  reg [7 : 0] s0x06_reg;
  reg [7 : 0] s0x06_new;
  reg         s0x06_we;

  reg [7 : 0] s0x07_reg;
  reg [7 : 0] s0x07_new;
  reg         s0x07_we;

  reg [7 : 0] s0x08_reg;
  reg [7 : 0] s0x08_new;
  reg         s0x08_we;

  reg [7 : 0] s0x09_reg;
  reg [7 : 0] s0x09_new;
  reg         s0x09_we;

  reg [7 : 0] s0x0a_reg;
  reg [7 : 0] s0x0a_new;
  reg         s0x0a_we;

  reg [7 : 0] s0x0b_reg;
  reg [7 : 0] s0x0b_new;
  reg         s0x0b_we;

  reg [7 : 0] s0x0c_reg;
  reg [7 : 0] s0x0c_new;
  reg         s0x0c_we;

  reg [7 : 0] s0x0d_reg;
  reg [7 : 0] s0x0d_new;
  reg         s0x0d_we;

  reg [7 : 0] s0x0e_reg;
  reg [7 : 0] s0x0e_new;
  reg         s0x0e_we;

  reg [7 : 0] s0x0f_reg;
  reg [7 : 0] s0x0f_new;
  reg         s0x0f_we;

  reg [7 : 0] s0x10_reg;
  reg [7 : 0] s0x10_new;
  reg         s0x10_we;

  reg [7 : 0] s0x11_reg;
  reg [7 : 0] s0x11_new;
  reg         s0x11_we;

  reg [7 : 0] s0x12_reg;
  reg [7 : 0] s0x12_new;
  reg         s0x12_we;

  reg [7 : 0] s0x13_reg;
  reg [7 : 0] s0x13_new;
  reg         s0x13_we;

  reg [7 : 0] s0x14_reg;
  reg [7 : 0] s0x14_new;
  reg         s0x14_we;

  reg [7 : 0] s0x15_reg;
  reg [7 : 0] s0x15_new;
  reg         s0x15_we;

  reg [7 : 0] s0x16_reg;
  reg [7 : 0] s0x16_new;
  reg         s0x16_we;

  reg [7 : 0] s0x17_reg;
  reg [7 : 0] s0x17_new;
  reg         s0x17_we;

  reg [7 : 0] s0x18_reg;
  reg [7 : 0] s0x18_new;
  reg         s0x18_we;

  reg [7 : 0] s0x19_reg;
  reg [7 : 0] s0x19_new;
  reg         s0x19_we;

  reg [7 : 0] s0x1a_reg;
  reg [7 : 0] s0x1a_new;
  reg         s0x1a_we;

  reg [7 : 0] s0x1b_reg;
  reg [7 : 0] s0x1b_new;
  reg         s0x1b_we;

  reg [7 : 0] s0x1c_reg;
  reg [7 : 0] s0x1c_new;
  reg         s0x1c_we;

  reg [7 : 0] s0x1d_reg;
  reg [7 : 0] s0x1d_new;
  reg         s0x1d_we;

  reg [7 : 0] s0x1e_reg;
  reg [7 : 0] s0x1e_new;
  reg         s0x1e_we;

  reg [7 : 0] s0x1f_reg;
  reg [7 : 0] s0x1f_new;
  reg         s0x1f_we;

  reg [7 : 0] s0x20_reg;
  reg [7 : 0] s0x20_new;
  reg         s0x20_we;

  reg [7 : 0] s0x21_reg;
  reg [7 : 0] s0x21_new;
  reg         s0x21_we;

  reg [7 : 0] s0x22_reg;
  reg [7 : 0] s0x22_new;
  reg         s0x22_we;

  reg [7 : 0] s0x23_reg;
  reg [7 : 0] s0x23_new;
  reg         s0x23_we;

  reg [7 : 0] s0x24_reg;
  reg [7 : 0] s0x24_new;
  reg         s0x24_we;

  reg [7 : 0] s0x25_reg;
  reg [7 : 0] s0x25_new;
  reg         s0x25_we;

  reg [7 : 0] s0x26_reg;
  reg [7 : 0] s0x26_new;
  reg         s0x26_we;

  reg [7 : 0] s0x27_reg;
  reg [7 : 0] s0x27_new;
  reg         s0x27_we;

  reg [7 : 0] s0x28_reg;
  reg [7 : 0] s0x28_new;
  reg         s0x28_we;

  reg [7 : 0] s0x29_reg;
  reg [7 : 0] s0x29_new;
  reg         s0x29_we;

  reg [7 : 0] s0x2a_reg;
  reg [7 : 0] s0x2a_new;
  reg         s0x2a_we;

  reg [7 : 0] s0x2b_reg;
  reg [7 : 0] s0x2b_new;
  reg         s0x2b_we;

  reg [7 : 0] s0x2c_reg;
  reg [7 : 0] s0x2c_new;
  reg         s0x2c_we;

  reg [7 : 0] s0x2d_reg;
  reg [7 : 0] s0x2d_new;
  reg         s0x2d_we;

  reg [7 : 0] s0x2e_reg;
  reg [7 : 0] s0x2e_new;
  reg         s0x2e_we;

  reg [7 : 0] s0x2f_reg;
  reg [7 : 0] s0x2f_new;
  reg         s0x2f_we;

  reg [7 : 0] s0x30_reg;
  reg [7 : 0] s0x30_new;
  reg         s0x30_we;

  reg [7 : 0] s0x31_reg;
  reg [7 : 0] s0x31_new;
  reg         s0x31_we;

  reg [7 : 0] s0x32_reg;
  reg [7 : 0] s0x32_new;
  reg         s0x32_we;

  reg [7 : 0] s0x33_reg;
  reg [7 : 0] s0x33_new;
  reg         s0x33_we;

  reg [7 : 0] s0x34_reg;
  reg [7 : 0] s0x34_new;
  reg         s0x34_we;

  reg [7 : 0] s0x35_reg;
  reg [7 : 0] s0x35_new;
  reg         s0x35_we;

  reg [7 : 0] s0x36_reg;
  reg [7 : 0] s0x36_new;
  reg         s0x36_we;

  reg [7 : 0] s0x37_reg;
  reg [7 : 0] s0x37_new;
  reg         s0x37_we;

  reg [7 : 0] s0x38_reg;
  reg [7 : 0] s0x38_new;
  reg         s0x38_we;

  reg [7 : 0] s0x39_reg;
  reg [7 : 0] s0x39_new;
  reg         s0x39_we;

  reg [7 : 0] s0x3a_reg;
  reg [7 : 0] s0x3a_new;
  reg         s0x3a_we;

  reg [7 : 0] s0x3b_reg;
  reg [7 : 0] s0x3b_new;
  reg         s0x3b_we;

  reg [7 : 0] s0x3c_reg;
  reg [7 : 0] s0x3c_new;
  reg         s0x3c_we;

  reg [7 : 0] s0x3d_reg;
  reg [7 : 0] s0x3d_new;
  reg         s0x3d_we;

  reg [7 : 0] s0x3e_reg;
  reg [7 : 0] s0x3e_new;
  reg         s0x3e_we;

  reg [7 : 0] s0x3f_reg;
  reg [7 : 0] s0x3f_new;
  reg         s0x3f_we;

  reg [7 : 0] s0x40_reg;
  reg [7 : 0] s0x40_new;
  reg         s0x40_we;

  reg [7 : 0] s0x41_reg;
  reg [7 : 0] s0x41_new;
  reg         s0x41_we;

  reg [7 : 0] s0x42_reg;
  reg [7 : 0] s0x42_new;
  reg         s0x42_we;

  reg [7 : 0] s0x43_reg;
  reg [7 : 0] s0x43_new;
  reg         s0x43_we;

  reg [7 : 0] s0x44_reg;
  reg [7 : 0] s0x44_new;
  reg         s0x44_we;

  reg [7 : 0] s0x45_reg;
  reg [7 : 0] s0x45_new;
  reg         s0x45_we;

  reg [7 : 0] s0x46_reg;
  reg [7 : 0] s0x46_new;
  reg         s0x46_we;

  reg [7 : 0] s0x47_reg;
  reg [7 : 0] s0x47_new;
  reg         s0x47_we;

  reg [7 : 0] s0x48_reg;
  reg [7 : 0] s0x48_new;
  reg         s0x48_we;

  reg [7 : 0] s0x49_reg;
  reg [7 : 0] s0x49_new;
  reg         s0x49_we;

  reg [7 : 0] s0x4a_reg;
  reg [7 : 0] s0x4a_new;
  reg         s0x4a_we;

  reg [7 : 0] s0x4b_reg;
  reg [7 : 0] s0x4b_new;
  reg         s0x4b_we;

  reg [7 : 0] s0x4c_reg;
  reg [7 : 0] s0x4c_new;
  reg         s0x4c_we;

  reg [7 : 0] s0x4d_reg;
  reg [7 : 0] s0x4d_new;
  reg         s0x4d_we;

  reg [7 : 0] s0x4e_reg;
  reg [7 : 0] s0x4e_new;
  reg         s0x4e_we;

  reg [7 : 0] s0x4f_reg;
  reg [7 : 0] s0x4f_new;
  reg         s0x4f_we;

  reg [7 : 0] s0x50_reg;
  reg [7 : 0] s0x50_new;
  reg         s0x50_we;

  reg [7 : 0] s0x51_reg;
  reg [7 : 0] s0x51_new;
  reg         s0x51_we;

  reg [7 : 0] s0x52_reg;
  reg [7 : 0] s0x52_new;
  reg         s0x52_we;

  reg [7 : 0] s0x53_reg;
  reg [7 : 0] s0x53_new;
  reg         s0x53_we;

  reg [7 : 0] s0x54_reg;
  reg [7 : 0] s0x54_new;
  reg         s0x54_we;

  reg [7 : 0] s0x55_reg;
  reg [7 : 0] s0x55_new;
  reg         s0x55_we;

  reg [7 : 0] s0x56_reg;
  reg [7 : 0] s0x56_new;
  reg         s0x56_we;

  reg [7 : 0] s0x57_reg;
  reg [7 : 0] s0x57_new;
  reg         s0x57_we;

  reg [7 : 0] s0x58_reg;
  reg [7 : 0] s0x58_new;
  reg         s0x58_we;

  reg [7 : 0] s0x59_reg;
  reg [7 : 0] s0x59_new;
  reg         s0x59_we;

  reg [7 : 0] s0x5a_reg;
  reg [7 : 0] s0x5a_new;
  reg         s0x5a_we;

  reg [7 : 0] s0x5b_reg;
  reg [7 : 0] s0x5b_new;
  reg         s0x5b_we;

  reg [7 : 0] s0x5c_reg;
  reg [7 : 0] s0x5c_new;
  reg         s0x5c_we;

  reg [7 : 0] s0x5d_reg;
  reg [7 : 0] s0x5d_new;
  reg         s0x5d_we;

  reg [7 : 0] s0x5e_reg;
  reg [7 : 0] s0x5e_new;
  reg         s0x5e_we;

  reg [7 : 0] s0x5f_reg;
  reg [7 : 0] s0x5f_new;
  reg         s0x5f_we;

  reg [7 : 0] s0x60_reg;
  reg [7 : 0] s0x60_new;
  reg         s0x60_we;

  reg [7 : 0] s0x61_reg;
  reg [7 : 0] s0x61_new;
  reg         s0x61_we;

  reg [7 : 0] s0x62_reg;
  reg [7 : 0] s0x62_new;
  reg         s0x62_we;

  reg [7 : 0] s0x63_reg;
  reg [7 : 0] s0x63_new;
  reg         s0x63_we;

  reg [7 : 0] s0x64_reg;
  reg [7 : 0] s0x64_new;
  reg         s0x64_we;

  reg [7 : 0] s0x65_reg;
  reg [7 : 0] s0x65_new;
  reg         s0x65_we;

  reg [7 : 0] s0x66_reg;
  reg [7 : 0] s0x66_new;
  reg         s0x66_we;

  reg [7 : 0] s0x67_reg;
  reg [7 : 0] s0x67_new;
  reg         s0x67_we;

  reg [7 : 0] s0x68_reg;
  reg [7 : 0] s0x68_new;
  reg         s0x68_we;

  reg [7 : 0] s0x69_reg;
  reg [7 : 0] s0x69_new;
  reg         s0x69_we;

  reg [7 : 0] s0x6a_reg;
  reg [7 : 0] s0x6a_new;
  reg         s0x6a_we;

  reg [7 : 0] s0x6b_reg;
  reg [7 : 0] s0x6b_new;
  reg         s0x6b_we;

  reg [7 : 0] s0x6c_reg;
  reg [7 : 0] s0x6c_new;
  reg         s0x6c_we;

  reg [7 : 0] s0x6d_reg;
  reg [7 : 0] s0x6d_new;
  reg         s0x6d_we;

  reg [7 : 0] s0x6e_reg;
  reg [7 : 0] s0x6e_new;
  reg         s0x6e_we;

  reg [7 : 0] s0x6f_reg;
  reg [7 : 0] s0x6f_new;
  reg         s0x6f_we;

  reg [7 : 0] s0x70_reg;
  reg [7 : 0] s0x70_new;
  reg         s0x70_we;

  reg [7 : 0] s0x71_reg;
  reg [7 : 0] s0x71_new;
  reg         s0x71_we;

  reg [7 : 0] s0x72_reg;
  reg [7 : 0] s0x72_new;
  reg         s0x72_we;

  reg [7 : 0] s0x73_reg;
  reg [7 : 0] s0x73_new;
  reg         s0x73_we;

  reg [7 : 0] s0x74_reg;
  reg [7 : 0] s0x74_new;
  reg         s0x74_we;

  reg [7 : 0] s0x75_reg;
  reg [7 : 0] s0x75_new;
  reg         s0x75_we;

  reg [7 : 0] s0x76_reg;
  reg [7 : 0] s0x76_new;
  reg         s0x76_we;

  reg [7 : 0] s0x77_reg;
  reg [7 : 0] s0x77_new;
  reg         s0x77_we;

  reg [7 : 0] s0x78_reg;
  reg [7 : 0] s0x78_new;
  reg         s0x78_we;

  reg [7 : 0] s0x79_reg;
  reg [7 : 0] s0x79_new;
  reg         s0x79_we;

  reg [7 : 0] s0x7a_reg;
  reg [7 : 0] s0x7a_new;
  reg         s0x7a_we;

  reg [7 : 0] s0x7b_reg;
  reg [7 : 0] s0x7b_new;
  reg         s0x7b_we;

  reg [7 : 0] s0x7c_reg;
  reg [7 : 0] s0x7c_new;
  reg         s0x7c_we;

  reg [7 : 0] s0x7d_reg;
  reg [7 : 0] s0x7d_new;
  reg         s0x7d_we;

  reg [7 : 0] s0x7e_reg;
  reg [7 : 0] s0x7e_new;
  reg         s0x7e_we;

  reg [7 : 0] s0x7f_reg;
  reg [7 : 0] s0x7f_new;
  reg         s0x7f_we;

  reg [7 : 0] s0x80_reg;
  reg [7 : 0] s0x80_new;
  reg         s0x80_we;

  reg [7 : 0] s0x81_reg;
  reg [7 : 0] s0x81_new;
  reg         s0x81_we;

  reg [7 : 0] s0x82_reg;
  reg [7 : 0] s0x82_new;
  reg         s0x82_we;

  reg [7 : 0] s0x83_reg;
  reg [7 : 0] s0x83_new;
  reg         s0x83_we;

  reg [7 : 0] s0x84_reg;
  reg [7 : 0] s0x84_new;
  reg         s0x84_we;

  reg [7 : 0] s0x85_reg;
  reg [7 : 0] s0x85_new;
  reg         s0x85_we;

  reg [7 : 0] s0x86_reg;
  reg [7 : 0] s0x86_new;
  reg         s0x86_we;

  reg [7 : 0] s0x87_reg;
  reg [7 : 0] s0x87_new;
  reg         s0x87_we;

  reg [7 : 0] s0x88_reg;
  reg [7 : 0] s0x88_new;
  reg         s0x88_we;

  reg [7 : 0] s0x89_reg;
  reg [7 : 0] s0x89_new;
  reg         s0x89_we;

  reg [7 : 0] s0x8a_reg;
  reg [7 : 0] s0x8a_new;
  reg         s0x8a_we;

  reg [7 : 0] s0x8b_reg;
  reg [7 : 0] s0x8b_new;
  reg         s0x8b_we;

  reg [7 : 0] s0x8c_reg;
  reg [7 : 0] s0x8c_new;
  reg         s0x8c_we;

  reg [7 : 0] s0x8d_reg;
  reg [7 : 0] s0x8d_new;
  reg         s0x8d_we;

  reg [7 : 0] s0x8e_reg;
  reg [7 : 0] s0x8e_new;
  reg         s0x8e_we;

  reg [7 : 0] s0x8f_reg;
  reg [7 : 0] s0x8f_new;
  reg         s0x8f_we;

  reg [7 : 0] s0x90_reg;
  reg [7 : 0] s0x90_new;
  reg         s0x90_we;

  reg [7 : 0] s0x91_reg;
  reg [7 : 0] s0x91_new;
  reg         s0x91_we;

  reg [7 : 0] s0x92_reg;
  reg [7 : 0] s0x92_new;
  reg         s0x92_we;

  reg [7 : 0] s0x93_reg;
  reg [7 : 0] s0x93_new;
  reg         s0x93_we;

  reg [7 : 0] s0x94_reg;
  reg [7 : 0] s0x94_new;
  reg         s0x94_we;

  reg [7 : 0] s0x95_reg;
  reg [7 : 0] s0x95_new;
  reg         s0x95_we;

  reg [7 : 0] s0x96_reg;
  reg [7 : 0] s0x96_new;
  reg         s0x96_we;

  reg [7 : 0] s0x97_reg;
  reg [7 : 0] s0x97_new;
  reg         s0x97_we;

  reg [7 : 0] s0x98_reg;
  reg [7 : 0] s0x98_new;
  reg         s0x98_we;

  reg [7 : 0] s0x99_reg;
  reg [7 : 0] s0x99_new;
  reg         s0x99_we;

  reg [7 : 0] s0x9a_reg;
  reg [7 : 0] s0x9a_new;
  reg         s0x9a_we;

  reg [7 : 0] s0x9b_reg;
  reg [7 : 0] s0x9b_new;
  reg         s0x9b_we;

  reg [7 : 0] s0x9c_reg;
  reg [7 : 0] s0x9c_new;
  reg         s0x9c_we;

  reg [7 : 0] s0x9d_reg;
  reg [7 : 0] s0x9d_new;
  reg         s0x9d_we;

  reg [7 : 0] s0x9e_reg;
  reg [7 : 0] s0x9e_new;
  reg         s0x9e_we;

  reg [7 : 0] s0x9f_reg;
  reg [7 : 0] s0x9f_new;
  reg         s0x9f_we;

  reg [7 : 0] s0xa0_reg;
  reg [7 : 0] s0xa0_new;
  reg         s0xa0_we;

  reg [7 : 0] s0xa1_reg;
  reg [7 : 0] s0xa1_new;
  reg         s0xa1_we;

  reg [7 : 0] s0xa2_reg;
  reg [7 : 0] s0xa2_new;
  reg         s0xa2_we;

  reg [7 : 0] s0xa3_reg;
  reg [7 : 0] s0xa3_new;
  reg         s0xa3_we;

  reg [7 : 0] s0xa4_reg;
  reg [7 : 0] s0xa4_new;
  reg         s0xa4_we;

  reg [7 : 0] s0xa5_reg;
  reg [7 : 0] s0xa5_new;
  reg         s0xa5_we;

  reg [7 : 0] s0xa6_reg;
  reg [7 : 0] s0xa6_new;
  reg         s0xa6_we;

  reg [7 : 0] s0xa7_reg;
  reg [7 : 0] s0xa7_new;
  reg         s0xa7_we;

  reg [7 : 0] s0xa8_reg;
  reg [7 : 0] s0xa8_new;
  reg         s0xa8_we;

  reg [7 : 0] s0xa9_reg;
  reg [7 : 0] s0xa9_new;
  reg         s0xa9_we;

  reg [7 : 0] s0xaa_reg;
  reg [7 : 0] s0xaa_new;
  reg         s0xaa_we;

  reg [7 : 0] s0xab_reg;
  reg [7 : 0] s0xab_new;
  reg         s0xab_we;

  reg [7 : 0] s0xac_reg;
  reg [7 : 0] s0xac_new;
  reg         s0xac_we;

  reg [7 : 0] s0xad_reg;
  reg [7 : 0] s0xad_new;
  reg         s0xad_we;

  reg [7 : 0] s0xae_reg;
  reg [7 : 0] s0xae_new;
  reg         s0xae_we;

  reg [7 : 0] s0xaf_reg;
  reg [7 : 0] s0xaf_new;
  reg         s0xaf_we;

  reg [7 : 0] s0xb0_reg;
  reg [7 : 0] s0xb0_new;
  reg         s0xb0_we;

  reg [7 : 0] s0xb1_reg;
  reg [7 : 0] s0xb1_new;
  reg         s0xb1_we;

  reg [7 : 0] s0xb2_reg;
  reg [7 : 0] s0xb2_new;
  reg         s0xb2_we;

  reg [7 : 0] s0xb3_reg;
  reg [7 : 0] s0xb3_new;
  reg         s0xb3_we;

  reg [7 : 0] s0xb4_reg;
  reg [7 : 0] s0xb4_new;
  reg         s0xb4_we;

  reg [7 : 0] s0xb5_reg;
  reg [7 : 0] s0xb5_new;
  reg         s0xb5_we;

  reg [7 : 0] s0xb6_reg;
  reg [7 : 0] s0xb6_new;
  reg         s0xb6_we;

  reg [7 : 0] s0xb7_reg;
  reg [7 : 0] s0xb7_new;
  reg         s0xb7_we;

  reg [7 : 0] s0xb8_reg;
  reg [7 : 0] s0xb8_new;
  reg         s0xb8_we;

  reg [7 : 0] s0xb9_reg;
  reg [7 : 0] s0xb9_new;
  reg         s0xb9_we;

  reg [7 : 0] s0xba_reg;
  reg [7 : 0] s0xba_new;
  reg         s0xba_we;

  reg [7 : 0] s0xbb_reg;
  reg [7 : 0] s0xbb_new;
  reg         s0xbb_we;

  reg [7 : 0] s0xbc_reg;
  reg [7 : 0] s0xbc_new;
  reg         s0xbc_we;

  reg [7 : 0] s0xbd_reg;
  reg [7 : 0] s0xbd_new;
  reg         s0xbd_we;

  reg [7 : 0] s0xbe_reg;
  reg [7 : 0] s0xbe_new;
  reg         s0xbe_we;

  reg [7 : 0] s0xbf_reg;
  reg [7 : 0] s0xbf_new;
  reg         s0xbf_we;

  reg [7 : 0] s0xc0_reg;
  reg [7 : 0] s0xc0_new;
  reg         s0xc0_we;

  reg [7 : 0] s0xc1_reg;
  reg [7 : 0] s0xc1_new;
  reg         s0xc1_we;

  reg [7 : 0] s0xc2_reg;
  reg [7 : 0] s0xc2_new;
  reg         s0xc2_we;

  reg [7 : 0] s0xc3_reg;
  reg [7 : 0] s0xc3_new;
  reg         s0xc3_we;

  reg [7 : 0] s0xc4_reg;
  reg [7 : 0] s0xc4_new;
  reg         s0xc4_we;

  reg [7 : 0] s0xc5_reg;
  reg [7 : 0] s0xc5_new;
  reg         s0xc5_we;

  reg [7 : 0] s0xc6_reg;
  reg [7 : 0] s0xc6_new;
  reg         s0xc6_we;

  reg [7 : 0] s0xc7_reg;
  reg [7 : 0] s0xc7_new;
  reg         s0xc7_we;

  reg [7 : 0] s0xc8_reg;
  reg [7 : 0] s0xc8_new;
  reg         s0xc8_we;

  reg [7 : 0] s0xc9_reg;
  reg [7 : 0] s0xc9_new;
  reg         s0xc9_we;

  reg [7 : 0] s0xca_reg;
  reg [7 : 0] s0xca_new;
  reg         s0xca_we;

  reg [7 : 0] s0xcb_reg;
  reg [7 : 0] s0xcb_new;
  reg         s0xcb_we;

  reg [7 : 0] s0xcc_reg;
  reg [7 : 0] s0xcc_new;
  reg         s0xcc_we;

  reg [7 : 0] s0xcd_reg;
  reg [7 : 0] s0xcd_new;
  reg         s0xcd_we;

  reg [7 : 0] s0xce_reg;
  reg [7 : 0] s0xce_new;
  reg         s0xce_we;

  reg [7 : 0] s0xcf_reg;
  reg [7 : 0] s0xcf_new;
  reg         s0xcf_we;

  reg [7 : 0] s0xd0_reg;
  reg [7 : 0] s0xd0_new;
  reg         s0xd0_we;

  reg [7 : 0] s0xd1_reg;
  reg [7 : 0] s0xd1_new;
  reg         s0xd1_we;

  reg [7 : 0] s0xd2_reg;
  reg [7 : 0] s0xd2_new;
  reg         s0xd2_we;

  reg [7 : 0] s0xd3_reg;
  reg [7 : 0] s0xd3_new;
  reg         s0xd3_we;

  reg [7 : 0] s0xd4_reg;
  reg [7 : 0] s0xd4_new;
  reg         s0xd4_we;

  reg [7 : 0] s0xd5_reg;
  reg [7 : 0] s0xd5_new;
  reg         s0xd5_we;

  reg [7 : 0] s0xd6_reg;
  reg [7 : 0] s0xd6_new;
  reg         s0xd6_we;

  reg [7 : 0] s0xd7_reg;
  reg [7 : 0] s0xd7_new;
  reg         s0xd7_we;

  reg [7 : 0] s0xd8_reg;
  reg [7 : 0] s0xd8_new;
  reg         s0xd8_we;

  reg [7 : 0] s0xd9_reg;
  reg [7 : 0] s0xd9_new;
  reg         s0xd9_we;

  reg [7 : 0] s0xda_reg;
  reg [7 : 0] s0xda_new;
  reg         s0xda_we;

  reg [7 : 0] s0xdb_reg;
  reg [7 : 0] s0xdb_new;
  reg         s0xdb_we;

  reg [7 : 0] s0xdc_reg;
  reg [7 : 0] s0xdc_new;
  reg         s0xdc_we;

  reg [7 : 0] s0xdd_reg;
  reg [7 : 0] s0xdd_new;
  reg         s0xdd_we;

  reg [7 : 0] s0xde_reg;
  reg [7 : 0] s0xde_new;
  reg         s0xde_we;

  reg [7 : 0] s0xdf_reg;
  reg [7 : 0] s0xdf_new;
  reg         s0xdf_we;

  reg [7 : 0] s0xe0_reg;
  reg [7 : 0] s0xe0_new;
  reg         s0xe0_we;

  reg [7 : 0] s0xe1_reg;
  reg [7 : 0] s0xe1_new;
  reg         s0xe1_we;

  reg [7 : 0] s0xe2_reg;
  reg [7 : 0] s0xe2_new;
  reg         s0xe2_we;

  reg [7 : 0] s0xe3_reg;
  reg [7 : 0] s0xe3_new;
  reg         s0xe3_we;

  reg [7 : 0] s0xe4_reg;
  reg [7 : 0] s0xe4_new;
  reg         s0xe4_we;

  reg [7 : 0] s0xe5_reg;
  reg [7 : 0] s0xe5_new;
  reg         s0xe5_we;

  reg [7 : 0] s0xe6_reg;
  reg [7 : 0] s0xe6_new;
  reg         s0xe6_we;

  reg [7 : 0] s0xe7_reg;
  reg [7 : 0] s0xe7_new;
  reg         s0xe7_we;

  reg [7 : 0] s0xe8_reg;
  reg [7 : 0] s0xe8_new;
  reg         s0xe8_we;

  reg [7 : 0] s0xe9_reg;
  reg [7 : 0] s0xe9_new;
  reg         s0xe9_we;

  reg [7 : 0] s0xea_reg;
  reg [7 : 0] s0xea_new;
  reg         s0xea_we;

  reg [7 : 0] s0xeb_reg;
  reg [7 : 0] s0xeb_new;
  reg         s0xeb_we;

  reg [7 : 0] s0xec_reg;
  reg [7 : 0] s0xec_new;
  reg         s0xec_we;

  reg [7 : 0] s0xed_reg;
  reg [7 : 0] s0xed_new;
  reg         s0xed_we;

  reg [7 : 0] s0xee_reg;
  reg [7 : 0] s0xee_new;
  reg         s0xee_we;

  reg [7 : 0] s0xef_reg;
  reg [7 : 0] s0xef_new;
  reg         s0xef_we;

  reg [7 : 0] s0xf0_reg;
  reg [7 : 0] s0xf0_new;
  reg         s0xf0_we;

  reg [7 : 0] s0xf1_reg;
  reg [7 : 0] s0xf1_new;
  reg         s0xf1_we;

  reg [7 : 0] s0xf2_reg;
  reg [7 : 0] s0xf2_new;
  reg         s0xf2_we;

  reg [7 : 0] s0xf3_reg;
  reg [7 : 0] s0xf3_new;
  reg         s0xf3_we;

  reg [7 : 0] s0xf4_reg;
  reg [7 : 0] s0xf4_new;
  reg         s0xf4_we;

  reg [7 : 0] s0xf5_reg;
  reg [7 : 0] s0xf5_new;
  reg         s0xf5_we;

  reg [7 : 0] s0xf6_reg;
  reg [7 : 0] s0xf6_new;
  reg         s0xf6_we;

  reg [7 : 0] s0xf7_reg;
  reg [7 : 0] s0xf7_new;
  reg         s0xf7_we;

  reg [7 : 0] s0xf8_reg;
  reg [7 : 0] s0xf8_new;
  reg         s0xf8_we;

  reg [7 : 0] s0xf9_reg;
  reg [7 : 0] s0xf9_new;
  reg         s0xf9_we;

  reg [7 : 0] s0xfa_reg;
  reg [7 : 0] s0xfa_new;
  reg         s0xfa_we;

  reg [7 : 0] s0xfb_reg;
  reg [7 : 0] s0xfb_new;
  reg         s0xfb_we;

  reg [7 : 0] s0xfc_reg;
  reg [7 : 0] s0xfc_new;
  reg         s0xfc_we;

  reg [7 : 0] s0xfd_reg;
  reg [7 : 0] s0xfd_new;
  reg         s0xfd_we;

  reg [7 : 0] s0xfe_reg;
  reg [7 : 0] s0xfe_new;
  reg         s0xfe_we;

  reg [7 : 0] s0xff_reg;
  reg [7 : 0] s0xff_new;
  reg         s0xff_we;
  
  
  //----------------------------------------------------------------
  // Wires.
  //----------------------------------------------------------------
  
  
  //----------------------------------------------------------------
  // reg_update
  // Update functionality for all registers in the core.
  // All registers are positive edge triggered with synchronous
  // active low reset. All registers have write enable.
  //----------------------------------------------------------------
  always @ (posedge clk)
    begin : reg_update
      if (!reset_n)
        begin
          s0x00_reg <= 8'h00;
          s0x01_reg <= 8'h01;
          s0x02_reg <= 8'h02;
          s0x03_reg <= 8'h03;
          s0x04_reg <= 8'h04;
          s0x05_reg <= 8'h05;
          s0x06_reg <= 8'h06;
          s0x07_reg <= 8'h07;
          s0x08_reg <= 8'h08;
          s0x09_reg <= 8'h09;
          s0x0a_reg <= 8'h0a;
          s0x0b_reg <= 8'h0b;
          s0x0c_reg <= 8'h0c;
          s0x0d_reg <= 8'h0d;
          s0x0e_reg <= 8'h0e;
          s0x0f_reg <= 8'h0f;
          s0x10_reg <= 8'h10;
          s0x11_reg <= 8'h11;
          s0x12_reg <= 8'h12;
          s0x13_reg <= 8'h13;
          s0x14_reg <= 8'h14;
          s0x15_reg <= 8'h15;
          s0x16_reg <= 8'h16;
          s0x17_reg <= 8'h17;
          s0x18_reg <= 8'h18;
          s0x19_reg <= 8'h19;
          s0x1a_reg <= 8'h1a;
          s0x1b_reg <= 8'h1b;
          s0x1c_reg <= 8'h1c;
          s0x1d_reg <= 8'h1d;
          s0x1e_reg <= 8'h1e;
          s0x1f_reg <= 8'h1f;
          s0x20_reg <= 8'h20;
          s0x21_reg <= 8'h21;
          s0x22_reg <= 8'h22;
          s0x23_reg <= 8'h23;
          s0x24_reg <= 8'h24;
          s0x25_reg <= 8'h25;
          s0x26_reg <= 8'h26;
          s0x27_reg <= 8'h27;
          s0x28_reg <= 8'h28;
          s0x29_reg <= 8'h29;
          s0x2a_reg <= 8'h2a;
          s0x2b_reg <= 8'h2b;
          s0x2c_reg <= 8'h2c;
          s0x2d_reg <= 8'h2d;
          s0x2e_reg <= 8'h2e;
          s0x2f_reg <= 8'h2f;
          s0x30_reg <= 8'h30;
          s0x31_reg <= 8'h31;
          s0x32_reg <= 8'h32;
          s0x33_reg <= 8'h33;
          s0x34_reg <= 8'h34;
          s0x35_reg <= 8'h35;
          s0x36_reg <= 8'h36;
          s0x37_reg <= 8'h37;
          s0x38_reg <= 8'h38;
          s0x39_reg <= 8'h39;
          s0x3a_reg <= 8'h3a;
          s0x3b_reg <= 8'h3b;
          s0x3c_reg <= 8'h3c;
          s0x3d_reg <= 8'h3d;
          s0x3e_reg <= 8'h3e;
          s0x3f_reg <= 8'h3f;
          s0x40_reg <= 8'h40;
          s0x41_reg <= 8'h41;
          s0x42_reg <= 8'h42;
          s0x43_reg <= 8'h43;
          s0x44_reg <= 8'h44;
          s0x45_reg <= 8'h45;
          s0x46_reg <= 8'h46;
          s0x47_reg <= 8'h47;
          s0x48_reg <= 8'h48;
          s0x49_reg <= 8'h49;
          s0x4a_reg <= 8'h4a;
          s0x4b_reg <= 8'h4b;
          s0x4c_reg <= 8'h4c;
          s0x4d_reg <= 8'h4d;
          s0x4e_reg <= 8'h4e;
          s0x4f_reg <= 8'h4f;
          s0x50_reg <= 8'h50;
          s0x51_reg <= 8'h51;
          s0x52_reg <= 8'h52;
          s0x53_reg <= 8'h53;
          s0x54_reg <= 8'h54;
          s0x55_reg <= 8'h55;
          s0x56_reg <= 8'h56;
          s0x57_reg <= 8'h57;
          s0x58_reg <= 8'h58;
          s0x59_reg <= 8'h59;
          s0x5a_reg <= 8'h5a;
          s0x5b_reg <= 8'h5b;
          s0x5c_reg <= 8'h5c;
          s0x5d_reg <= 8'h5d;
          s0x5e_reg <= 8'h5e;
          s0x5f_reg <= 8'h5f;
          s0x60_reg <= 8'h60;
          s0x61_reg <= 8'h61;
          s0x62_reg <= 8'h62;
          s0x63_reg <= 8'h63;
          s0x64_reg <= 8'h64;
          s0x65_reg <= 8'h65;
          s0x66_reg <= 8'h66;
          s0x67_reg <= 8'h67;
          s0x68_reg <= 8'h68;
          s0x69_reg <= 8'h69;
          s0x6a_reg <= 8'h6a;
          s0x6b_reg <= 8'h6b;
          s0x6c_reg <= 8'h6c;
          s0x6d_reg <= 8'h6d;
          s0x6e_reg <= 8'h6e;
          s0x6f_reg <= 8'h6f;
          s0x70_reg <= 8'h70;
          s0x71_reg <= 8'h71;
          s0x72_reg <= 8'h72;
          s0x73_reg <= 8'h73;
          s0x74_reg <= 8'h74;
          s0x75_reg <= 8'h75;
          s0x76_reg <= 8'h76;
          s0x77_reg <= 8'h77;
          s0x78_reg <= 8'h78;
          s0x79_reg <= 8'h79;
          s0x7a_reg <= 8'h7a;
          s0x7b_reg <= 8'h7b;
          s0x7c_reg <= 8'h7c;
          s0x7d_reg <= 8'h7d;
          s0x7e_reg <= 8'h7e;
          s0x7f_reg <= 8'h7f;
          s0x80_reg <= 8'h80;
          s0x81_reg <= 8'h81;
          s0x82_reg <= 8'h82;
          s0x83_reg <= 8'h83;
          s0x84_reg <= 8'h84;
          s0x85_reg <= 8'h85;
          s0x86_reg <= 8'h86;
          s0x87_reg <= 8'h87;
          s0x88_reg <= 8'h88;
          s0x89_reg <= 8'h89;
          s0x8a_reg <= 8'h8a;
          s0x8b_reg <= 8'h8b;
          s0x8c_reg <= 8'h8c;
          s0x8d_reg <= 8'h8d;
          s0x8e_reg <= 8'h8e;
          s0x8f_reg <= 8'h8f;
          s0x90_reg <= 8'h90;
          s0x91_reg <= 8'h91;
          s0x92_reg <= 8'h92;
          s0x93_reg <= 8'h93;
          s0x94_reg <= 8'h94;
          s0x95_reg <= 8'h95;
          s0x96_reg <= 8'h96;
          s0x97_reg <= 8'h97;
          s0x98_reg <= 8'h98;
          s0x99_reg <= 8'h99;
          s0x9a_reg <= 8'h9a;
          s0x9b_reg <= 8'h9b;
          s0x9c_reg <= 8'h9c;
          s0x9d_reg <= 8'h9d;
          s0x9e_reg <= 8'h9e;
          s0x9f_reg <= 8'h9f;
          s0xa0_reg <= 8'ha0;
          s0xa1_reg <= 8'ha1;
          s0xa2_reg <= 8'ha2;
          s0xa3_reg <= 8'ha3;
          s0xa4_reg <= 8'ha4;
          s0xa5_reg <= 8'ha5;
          s0xa6_reg <= 8'ha6;
          s0xa7_reg <= 8'ha7;
          s0xa8_reg <= 8'ha8;
          s0xa9_reg <= 8'ha9;
          s0xaa_reg <= 8'haa;
          s0xab_reg <= 8'hab;
          s0xac_reg <= 8'hac;
          s0xad_reg <= 8'had;
          s0xae_reg <= 8'hae;
          s0xaf_reg <= 8'haf;
          s0xb0_reg <= 8'hb0;
          s0xb1_reg <= 8'hb1;
          s0xb2_reg <= 8'hb2;
          s0xb3_reg <= 8'hb3;
          s0xb4_reg <= 8'hb4;
          s0xb5_reg <= 8'hb5;
          s0xb6_reg <= 8'hb6;
          s0xb7_reg <= 8'hb7;
          s0xb8_reg <= 8'hb8;
          s0xb9_reg <= 8'hb9;
          s0xba_reg <= 8'hba;
          s0xbb_reg <= 8'hbb;
          s0xbc_reg <= 8'hbc;
          s0xbd_reg <= 8'hbd;
          s0xbe_reg <= 8'hbe;
          s0xbf_reg <= 8'hbf;
          s0xc0_reg <= 8'hc0;
          s0xc1_reg <= 8'hc1;
          s0xc2_reg <= 8'hc2;
          s0xc3_reg <= 8'hc3;
          s0xc4_reg <= 8'hc4;
          s0xc5_reg <= 8'hc5;
          s0xc6_reg <= 8'hc6;
          s0xc7_reg <= 8'hc7;
          s0xc8_reg <= 8'hc8;
          s0xc9_reg <= 8'hc9;
          s0xca_reg <= 8'hca;
          s0xcb_reg <= 8'hcb;
          s0xcc_reg <= 8'hcc;
          s0xcd_reg <= 8'hcd;
          s0xce_reg <= 8'hce;
          s0xcf_reg <= 8'hcf;
          s0xd0_reg <= 8'hd0;
          s0xd1_reg <= 8'hd1;
          s0xd2_reg <= 8'hd2;
          s0xd3_reg <= 8'hd3;
          s0xd4_reg <= 8'hd4;
          s0xd5_reg <= 8'hd5;
          s0xd6_reg <= 8'hd6;
          s0xd7_reg <= 8'hd7;
          s0xd8_reg <= 8'hd8;
          s0xd9_reg <= 8'hd9;
          s0xda_reg <= 8'hda;
          s0xdb_reg <= 8'hdb;
          s0xdc_reg <= 8'hdc;
          s0xdd_reg <= 8'hdd;
          s0xde_reg <= 8'hde;
          s0xdf_reg <= 8'hdf;
          s0xe0_reg <= 8'he0;
          s0xe1_reg <= 8'he1;
          s0xe2_reg <= 8'he2;
          s0xe3_reg <= 8'he3;
          s0xe4_reg <= 8'he4;
          s0xe5_reg <= 8'he5;
          s0xe6_reg <= 8'he6;
          s0xe7_reg <= 8'he7;
          s0xe8_reg <= 8'he8;
          s0xe9_reg <= 8'he9;
          s0xea_reg <= 8'hea;
          s0xeb_reg <= 8'heb;
          s0xec_reg <= 8'hec;
          s0xed_reg <= 8'hed;
          s0xee_reg <= 8'hee;
          s0xef_reg <= 8'hef;
          s0xf0_reg <= 8'hf0;
          s0xf1_reg <= 8'hf1;
          s0xf2_reg <= 8'hf2;
          s0xf3_reg <= 8'hf3;
          s0xf4_reg <= 8'hf4;
          s0xf5_reg <= 8'hf5;
          s0xf6_reg <= 8'hf6;
          s0xf7_reg <= 8'hf7;
          s0xf8_reg <= 8'hf8;
          s0xf9_reg <= 8'hf9;
          s0xfa_reg <= 8'hfa;
          s0xfb_reg <= 8'hfb;
          s0xfc_reg <= 8'hfc;
          s0xfd_reg <= 8'hfd;
          s0xfe_reg <= 8'hfe;
          s0xff_reg <= 8'hff;
        end
      else
        begin
          if (s0x00_we)
            begin
              s0x00_reg <= s0x00_new;
            end

          if (s0x01_we)
            begin
              s0x01_reg <= s0x01_new;
            end

          if (s0x02_we)
            begin
              s0x02_reg <= s0x02_new;
            end

          if (s0x03_we)
            begin
              s0x03_reg <= s0x03_new;
            end

          if (s0x04_we)
            begin
              s0x04_reg <= s0x04_new;
            end

          if (s0x05_we)
            begin
              s0x05_reg <= s0x05_new;
            end

          if (s0x06_we)
            begin
              s0x06_reg <= s0x06_new;
            end

          if (s0x07_we)
            begin
              s0x07_reg <= s0x07_new;
            end

          if (s0x08_we)
            begin
              s0x08_reg <= s0x08_new;
            end

          if (s0x09_we)
            begin
              s0x09_reg <= s0x09_new;
            end

          if (s0x0a_we)
            begin
              s0x0a_reg <= s0x0a_new;
            end

          if (s0x0b_we)
            begin
              s0x0b_reg <= s0x0b_new;
            end

          if (s0x0c_we)
            begin
              s0x0c_reg <= s0x0c_new;
            end

          if (s0x0d_we)
            begin
              s0x0d_reg <= s0x0d_new;
            end

          if (s0x0e_we)
            begin
              s0x0e_reg <= s0x0e_new;
            end

          if (s0x0f_we)
            begin
              s0x0f_reg <= s0x0f_new;
            end

          if (s0x10_we)
            begin
              s0x10_reg <= s0x10_new;
            end

          if (s0x11_we)
            begin
              s0x11_reg <= s0x11_new;
            end

          if (s0x12_we)
            begin
              s0x12_reg <= s0x12_new;
            end

          if (s0x13_we)
            begin
              s0x13_reg <= s0x13_new;
            end

          if (s0x14_we)
            begin
              s0x14_reg <= s0x14_new;
            end

          if (s0x15_we)
            begin
              s0x15_reg <= s0x15_new;
            end

          if (s0x16_we)
            begin
              s0x16_reg <= s0x16_new;
            end

          if (s0x17_we)
            begin
              s0x17_reg <= s0x17_new;
            end

          if (s0x18_we)
            begin
              s0x18_reg <= s0x18_new;
            end

          if (s0x19_we)
            begin
              s0x19_reg <= s0x19_new;
            end

          if (s0x1a_we)
            begin
              s0x1a_reg <= s0x1a_new;
            end

          if (s0x1b_we)
            begin
              s0x1b_reg <= s0x1b_new;
            end

          if (s0x1c_we)
            begin
              s0x1c_reg <= s0x1c_new;
            end

          if (s0x1d_we)
            begin
              s0x1d_reg <= s0x1d_new;
            end

          if (s0x1e_we)
            begin
              s0x1e_reg <= s0x1e_new;
            end

          if (s0x1f_we)
            begin
              s0x1f_reg <= s0x1f_new;
            end

          if (s0x20_we)
            begin
              s0x20_reg <= s0x20_new;
            end

          if (s0x21_we)
            begin
              s0x21_reg <= s0x21_new;
            end

          if (s0x22_we)
            begin
              s0x22_reg <= s0x22_new;
            end

          if (s0x23_we)
            begin
              s0x23_reg <= s0x23_new;
            end

          if (s0x24_we)
            begin
              s0x24_reg <= s0x24_new;
            end

          if (s0x25_we)
            begin
              s0x25_reg <= s0x25_new;
            end

          if (s0x26_we)
            begin
              s0x26_reg <= s0x26_new;
            end

          if (s0x27_we)
            begin
              s0x27_reg <= s0x27_new;
            end

          if (s0x28_we)
            begin
              s0x28_reg <= s0x28_new;
            end

          if (s0x29_we)
            begin
              s0x29_reg <= s0x29_new;
            end

          if (s0x2a_we)
            begin
              s0x2a_reg <= s0x2a_new;
            end

          if (s0x2b_we)
            begin
              s0x2b_reg <= s0x2b_new;
            end

          if (s0x2c_we)
            begin
              s0x2c_reg <= s0x2c_new;
            end

          if (s0x2d_we)
            begin
              s0x2d_reg <= s0x2d_new;
            end

          if (s0x2e_we)
            begin
              s0x2e_reg <= s0x2e_new;
            end

          if (s0x2f_we)
            begin
              s0x2f_reg <= s0x2f_new;
            end

          if (s0x30_we)
            begin
              s0x30_reg <= s0x30_new;
            end

          if (s0x31_we)
            begin
              s0x31_reg <= s0x31_new;
            end

          if (s0x32_we)
            begin
              s0x32_reg <= s0x32_new;
            end

          if (s0x33_we)
            begin
              s0x33_reg <= s0x33_new;
            end

          if (s0x34_we)
            begin
              s0x34_reg <= s0x34_new;
            end

          if (s0x35_we)
            begin
              s0x35_reg <= s0x35_new;
            end

          if (s0x36_we)
            begin
              s0x36_reg <= s0x36_new;
            end

          if (s0x37_we)
            begin
              s0x37_reg <= s0x37_new;
            end

          if (s0x38_we)
            begin
              s0x38_reg <= s0x38_new;
            end

          if (s0x39_we)
            begin
              s0x39_reg <= s0x39_new;
            end

          if (s0x3a_we)
            begin
              s0x3a_reg <= s0x3a_new;
            end

          if (s0x3b_we)
            begin
              s0x3b_reg <= s0x3b_new;
            end

          if (s0x3c_we)
            begin
              s0x3c_reg <= s0x3c_new;
            end

          if (s0x3d_we)
            begin
              s0x3d_reg <= s0x3d_new;
            end

          if (s0x3e_we)
            begin
              s0x3e_reg <= s0x3e_new;
            end

          if (s0x3f_we)
            begin
              s0x3f_reg <= s0x3f_new;
            end

          if (s0x40_we)
            begin
              s0x40_reg <= s0x40_new;
            end

          if (s0x41_we)
            begin
              s0x41_reg <= s0x41_new;
            end

          if (s0x42_we)
            begin
              s0x42_reg <= s0x42_new;
            end

          if (s0x43_we)
            begin
              s0x43_reg <= s0x43_new;
            end

          if (s0x44_we)
            begin
              s0x44_reg <= s0x44_new;
            end

          if (s0x45_we)
            begin
              s0x45_reg <= s0x45_new;
            end

          if (s0x46_we)
            begin
              s0x46_reg <= s0x46_new;
            end

          if (s0x47_we)
            begin
              s0x47_reg <= s0x47_new;
            end

          if (s0x48_we)
            begin
              s0x48_reg <= s0x48_new;
            end

          if (s0x49_we)
            begin
              s0x49_reg <= s0x49_new;
            end

          if (s0x4a_we)
            begin
              s0x4a_reg <= s0x4a_new;
            end

          if (s0x4b_we)
            begin
              s0x4b_reg <= s0x4b_new;
            end

          if (s0x4c_we)
            begin
              s0x4c_reg <= s0x4c_new;
            end

          if (s0x4d_we)
            begin
              s0x4d_reg <= s0x4d_new;
            end

          if (s0x4e_we)
            begin
              s0x4e_reg <= s0x4e_new;
            end

          if (s0x4f_we)
            begin
              s0x4f_reg <= s0x4f_new;
            end

          if (s0x50_we)
            begin
              s0x50_reg <= s0x50_new;
            end

          if (s0x51_we)
            begin
              s0x51_reg <= s0x51_new;
            end

          if (s0x52_we)
            begin
              s0x52_reg <= s0x52_new;
            end

          if (s0x53_we)
            begin
              s0x53_reg <= s0x53_new;
            end

          if (s0x54_we)
            begin
              s0x54_reg <= s0x54_new;
            end

          if (s0x55_we)
            begin
              s0x55_reg <= s0x55_new;
            end

          if (s0x56_we)
            begin
              s0x56_reg <= s0x56_new;
            end

          if (s0x57_we)
            begin
              s0x57_reg <= s0x57_new;
            end

          if (s0x58_we)
            begin
              s0x58_reg <= s0x58_new;
            end

          if (s0x59_we)
            begin
              s0x59_reg <= s0x59_new;
            end

          if (s0x5a_we)
            begin
              s0x5a_reg <= s0x5a_new;
            end

          if (s0x5b_we)
            begin
              s0x5b_reg <= s0x5b_new;
            end

          if (s0x5c_we)
            begin
              s0x5c_reg <= s0x5c_new;
            end

          if (s0x5d_we)
            begin
              s0x5d_reg <= s0x5d_new;
            end

          if (s0x5e_we)
            begin
              s0x5e_reg <= s0x5e_new;
            end

          if (s0x5f_we)
            begin
              s0x5f_reg <= s0x5f_new;
            end

          if (s0x60_we)
            begin
              s0x60_reg <= s0x60_new;
            end

          if (s0x61_we)
            begin
              s0x61_reg <= s0x61_new;
            end

          if (s0x62_we)
            begin
              s0x62_reg <= s0x62_new;
            end

          if (s0x63_we)
            begin
              s0x63_reg <= s0x63_new;
            end

          if (s0x64_we)
            begin
              s0x64_reg <= s0x64_new;
            end

          if (s0x65_we)
            begin
              s0x65_reg <= s0x65_new;
            end

          if (s0x66_we)
            begin
              s0x66_reg <= s0x66_new;
            end

          if (s0x67_we)
            begin
              s0x67_reg <= s0x67_new;
            end

          if (s0x68_we)
            begin
              s0x68_reg <= s0x68_new;
            end

          if (s0x69_we)
            begin
              s0x69_reg <= s0x69_new;
            end

          if (s0x6a_we)
            begin
              s0x6a_reg <= s0x6a_new;
            end

          if (s0x6b_we)
            begin
              s0x6b_reg <= s0x6b_new;
            end

          if (s0x6c_we)
            begin
              s0x6c_reg <= s0x6c_new;
            end

          if (s0x6d_we)
            begin
              s0x6d_reg <= s0x6d_new;
            end

          if (s0x6e_we)
            begin
              s0x6e_reg <= s0x6e_new;
            end

          if (s0x6f_we)
            begin
              s0x6f_reg <= s0x6f_new;
            end

          if (s0x70_we)
            begin
              s0x70_reg <= s0x70_new;
            end

          if (s0x71_we)
            begin
              s0x71_reg <= s0x71_new;
            end

          if (s0x72_we)
            begin
              s0x72_reg <= s0x72_new;
            end

          if (s0x73_we)
            begin
              s0x73_reg <= s0x73_new;
            end

          if (s0x74_we)
            begin
              s0x74_reg <= s0x74_new;
            end

          if (s0x75_we)
            begin
              s0x75_reg <= s0x75_new;
            end

          if (s0x76_we)
            begin
              s0x76_reg <= s0x76_new;
            end

          if (s0x77_we)
            begin
              s0x77_reg <= s0x77_new;
            end

          if (s0x78_we)
            begin
              s0x78_reg <= s0x78_new;
            end

          if (s0x79_we)
            begin
              s0x79_reg <= s0x79_new;
            end

          if (s0x7a_we)
            begin
              s0x7a_reg <= s0x7a_new;
            end

          if (s0x7b_we)
            begin
              s0x7b_reg <= s0x7b_new;
            end

          if (s0x7c_we)
            begin
              s0x7c_reg <= s0x7c_new;
            end

          if (s0x7d_we)
            begin
              s0x7d_reg <= s0x7d_new;
            end

          if (s0x7e_we)
            begin
              s0x7e_reg <= s0x7e_new;
            end

          if (s0x7f_we)
            begin
              s0x7f_reg <= s0x7f_new;
            end

          if (s0x80_we)
            begin
              s0x80_reg <= s0x80_new;
            end

          if (s0x81_we)
            begin
              s0x81_reg <= s0x81_new;
            end

          if (s0x82_we)
            begin
              s0x82_reg <= s0x82_new;
            end

          if (s0x83_we)
            begin
              s0x83_reg <= s0x83_new;
            end

          if (s0x84_we)
            begin
              s0x84_reg <= s0x84_new;
            end

          if (s0x85_we)
            begin
              s0x85_reg <= s0x85_new;
            end

          if (s0x86_we)
            begin
              s0x86_reg <= s0x86_new;
            end

          if (s0x87_we)
            begin
              s0x87_reg <= s0x87_new;
            end

          if (s0x88_we)
            begin
              s0x88_reg <= s0x88_new;
            end

          if (s0x89_we)
            begin
              s0x89_reg <= s0x89_new;
            end

          if (s0x8a_we)
            begin
              s0x8a_reg <= s0x8a_new;
            end

          if (s0x8b_we)
            begin
              s0x8b_reg <= s0x8b_new;
            end

          if (s0x8c_we)
            begin
              s0x8c_reg <= s0x8c_new;
            end

          if (s0x8d_we)
            begin
              s0x8d_reg <= s0x8d_new;
            end

          if (s0x8e_we)
            begin
              s0x8e_reg <= s0x8e_new;
            end

          if (s0x8f_we)
            begin
              s0x8f_reg <= s0x8f_new;
            end

          if (s0x90_we)
            begin
              s0x90_reg <= s0x90_new;
            end

          if (s0x91_we)
            begin
              s0x91_reg <= s0x91_new;
            end

          if (s0x92_we)
            begin
              s0x92_reg <= s0x92_new;
            end

          if (s0x93_we)
            begin
              s0x93_reg <= s0x93_new;
            end

          if (s0x94_we)
            begin
              s0x94_reg <= s0x94_new;
            end

          if (s0x95_we)
            begin
              s0x95_reg <= s0x95_new;
            end

          if (s0x96_we)
            begin
              s0x96_reg <= s0x96_new;
            end

          if (s0x97_we)
            begin
              s0x97_reg <= s0x97_new;
            end

          if (s0x98_we)
            begin
              s0x98_reg <= s0x98_new;
            end

          if (s0x99_we)
            begin
              s0x99_reg <= s0x99_new;
            end

          if (s0x9a_we)
            begin
              s0x9a_reg <= s0x9a_new;
            end

          if (s0x9b_we)
            begin
              s0x9b_reg <= s0x9b_new;
            end

          if (s0x9c_we)
            begin
              s0x9c_reg <= s0x9c_new;
            end

          if (s0x9d_we)
            begin
              s0x9d_reg <= s0x9d_new;
            end

          if (s0x9e_we)
            begin
              s0x9e_reg <= s0x9e_new;
            end

          if (s0x9f_we)
            begin
              s0x9f_reg <= s0x9f_new;
            end

          if (s0xa0_we)
            begin
              s0xa0_reg <= s0xa0_new;
            end

          if (s0xa1_we)
            begin
              s0xa1_reg <= s0xa1_new;
            end

          if (s0xa2_we)
            begin
              s0xa2_reg <= s0xa2_new;
            end

          if (s0xa3_we)
            begin
              s0xa3_reg <= s0xa3_new;
            end

          if (s0xa4_we)
            begin
              s0xa4_reg <= s0xa4_new;
            end

          if (s0xa5_we)
            begin
              s0xa5_reg <= s0xa5_new;
            end

          if (s0xa6_we)
            begin
              s0xa6_reg <= s0xa6_new;
            end

          if (s0xa7_we)
            begin
              s0xa7_reg <= s0xa7_new;
            end

          if (s0xa8_we)
            begin
              s0xa8_reg <= s0xa8_new;
            end

          if (s0xa9_we)
            begin
              s0xa9_reg <= s0xa9_new;
            end

          if (s0xaa_we)
            begin
              s0xaa_reg <= s0xaa_new;
            end

          if (s0xab_we)
            begin
              s0xab_reg <= s0xab_new;
            end

          if (s0xac_we)
            begin
              s0xac_reg <= s0xac_new;
            end

          if (s0xad_we)
            begin
              s0xad_reg <= s0xad_new;
            end

          if (s0xae_we)
            begin
              s0xae_reg <= s0xae_new;
            end

          if (s0xaf_we)
            begin
              s0xaf_reg <= s0xaf_new;
            end

          if (s0xb0_we)
            begin
              s0xb0_reg <= s0xb0_new;
            end

          if (s0xb1_we)
            begin
              s0xb1_reg <= s0xb1_new;
            end

          if (s0xb2_we)
            begin
              s0xb2_reg <= s0xb2_new;
            end

          if (s0xb3_we)
            begin
              s0xb3_reg <= s0xb3_new;
            end

          if (s0xb4_we)
            begin
              s0xb4_reg <= s0xb4_new;
            end

          if (s0xb5_we)
            begin
              s0xb5_reg <= s0xb5_new;
            end

          if (s0xb6_we)
            begin
              s0xb6_reg <= s0xb6_new;
            end

          if (s0xb7_we)
            begin
              s0xb7_reg <= s0xb7_new;
            end

          if (s0xb8_we)
            begin
              s0xb8_reg <= s0xb8_new;
            end

          if (s0xb9_we)
            begin
              s0xb9_reg <= s0xb9_new;
            end

          if (s0xba_we)
            begin
              s0xba_reg <= s0xba_new;
            end

          if (s0xbb_we)
            begin
              s0xbb_reg <= s0xbb_new;
            end

          if (s0xbc_we)
            begin
              s0xbc_reg <= s0xbc_new;
            end

          if (s0xbd_we)
            begin
              s0xbd_reg <= s0xbd_new;
            end

          if (s0xbe_we)
            begin
              s0xbe_reg <= s0xbe_new;
            end

          if (s0xbf_we)
            begin
              s0xbf_reg <= s0xbf_new;
            end

          if (s0xc0_we)
            begin
              s0xc0_reg <= s0xc0_new;
            end

          if (s0xc1_we)
            begin
              s0xc1_reg <= s0xc1_new;
            end

          if (s0xc2_we)
            begin
              s0xc2_reg <= s0xc2_new;
            end

          if (s0xc3_we)
            begin
              s0xc3_reg <= s0xc3_new;
            end

          if (s0xc4_we)
            begin
              s0xc4_reg <= s0xc4_new;
            end

          if (s0xc5_we)
            begin
              s0xc5_reg <= s0xc5_new;
            end

          if (s0xc6_we)
            begin
              s0xc6_reg <= s0xc6_new;
            end

          if (s0xc7_we)
            begin
              s0xc7_reg <= s0xc7_new;
            end

          if (s0xc8_we)
            begin
              s0xc8_reg <= s0xc8_new;
            end

          if (s0xc9_we)
            begin
              s0xc9_reg <= s0xc9_new;
            end

          if (s0xca_we)
            begin
              s0xca_reg <= s0xca_new;
            end

          if (s0xcb_we)
            begin
              s0xcb_reg <= s0xcb_new;
            end

          if (s0xcc_we)
            begin
              s0xcc_reg <= s0xcc_new;
            end

          if (s0xcd_we)
            begin
              s0xcd_reg <= s0xcd_new;
            end

          if (s0xce_we)
            begin
              s0xce_reg <= s0xce_new;
            end

          if (s0xcf_we)
            begin
              s0xcf_reg <= s0xcf_new;
            end

          if (s0xd0_we)
            begin
              s0xd0_reg <= s0xd0_new;
            end

          if (s0xd1_we)
            begin
              s0xd1_reg <= s0xd1_new;
            end

          if (s0xd2_we)
            begin
              s0xd2_reg <= s0xd2_new;
            end

          if (s0xd3_we)
            begin
              s0xd3_reg <= s0xd3_new;
            end

          if (s0xd4_we)
            begin
              s0xd4_reg <= s0xd4_new;
            end

          if (s0xd5_we)
            begin
              s0xd5_reg <= s0xd5_new;
            end

          if (s0xd6_we)
            begin
              s0xd6_reg <= s0xd6_new;
            end

          if (s0xd7_we)
            begin
              s0xd7_reg <= s0xd7_new;
            end

          if (s0xd8_we)
            begin
              s0xd8_reg <= s0xd8_new;
            end

          if (s0xd9_we)
            begin
              s0xd9_reg <= s0xd9_new;
            end

          if (s0xda_we)
            begin
              s0xda_reg <= s0xda_new;
            end

          if (s0xdb_we)
            begin
              s0xdb_reg <= s0xdb_new;
            end

          if (s0xdc_we)
            begin
              s0xdc_reg <= s0xdc_new;
            end

          if (s0xdd_we)
            begin
              s0xdd_reg <= s0xdd_new;
            end

          if (s0xde_we)
            begin
              s0xde_reg <= s0xde_new;
            end

          if (s0xdf_we)
            begin
              s0xdf_reg <= s0xdf_new;
            end

          if (s0xe0_we)
            begin
              s0xe0_reg <= s0xe0_new;
            end

          if (s0xe1_we)
            begin
              s0xe1_reg <= s0xe1_new;
            end

          if (s0xe2_we)
            begin
              s0xe2_reg <= s0xe2_new;
            end

          if (s0xe3_we)
            begin
              s0xe3_reg <= s0xe3_new;
            end

          if (s0xe4_we)
            begin
              s0xe4_reg <= s0xe4_new;
            end

          if (s0xe5_we)
            begin
              s0xe5_reg <= s0xe5_new;
            end

          if (s0xe6_we)
            begin
              s0xe6_reg <= s0xe6_new;
            end

          if (s0xe7_we)
            begin
              s0xe7_reg <= s0xe7_new;
            end

          if (s0xe8_we)
            begin
              s0xe8_reg <= s0xe8_new;
            end

          if (s0xe9_we)
            begin
              s0xe9_reg <= s0xe9_new;
            end

          if (s0xea_we)
            begin
              s0xea_reg <= s0xea_new;
            end

          if (s0xeb_we)
            begin
              s0xeb_reg <= s0xeb_new;
            end

          if (s0xec_we)
            begin
              s0xec_reg <= s0xec_new;
            end

          if (s0xed_we)
            begin
              s0xed_reg <= s0xed_new;
            end

          if (s0xee_we)
            begin
              s0xee_reg <= s0xee_new;
            end

          if (s0xef_we)
            begin
              s0xef_reg <= s0xef_new;
            end

          if (s0xf0_we)
            begin
              s0xf0_reg <= s0xf0_new;
            end

          if (s0xf1_we)
            begin
              s0xf1_reg <= s0xf1_new;
            end

          if (s0xf2_we)
            begin
              s0xf2_reg <= s0xf2_new;
            end

          if (s0xf3_we)
            begin
              s0xf3_reg <= s0xf3_new;
            end

          if (s0xf4_we)
            begin
              s0xf4_reg <= s0xf4_new;
            end

          if (s0xf5_we)
            begin
              s0xf5_reg <= s0xf5_new;
            end

          if (s0xf6_we)
            begin
              s0xf6_reg <= s0xf6_new;
            end

          if (s0xf7_we)
            begin
              s0xf7_reg <= s0xf7_new;
            end

          if (s0xf8_we)
            begin
              s0xf8_reg <= s0xf8_new;
            end

          if (s0xf9_we)
            begin
              s0xf9_reg <= s0xf9_new;
            end

          if (s0xfa_we)
            begin
              s0xfa_reg <= s0xfa_new;
            end

          if (s0xfb_we)
            begin
              s0xfb_reg <= s0xfb_new;
            end

          if (s0xfc_we)
            begin
              s0xfc_reg <= s0xfc_new;
            end

          if (s0xfd_we)
            begin
              s0xfd_reg <= s0xfd_new;
            end

          if (s0xfe_we)
            begin
              s0xfe_reg <= s0xfe_new;
            end

          if (s0xff_we)
            begin
              s0xff_reg <= s0xff_new;
            end
        end
    end // reg_update

  //----------------------------------------------------------------
  // swap_bytes
  //
  // if swap is enabled swaps bytes pointed to by i_read_addr
  // and j_read_addr. If the pointers point to the same
  // state element, the second write operation will not
  // be done.
  //----------------------------------------------------------------
  always @*
    begin : swap_bytes
      s0x00 = 8'h00;
      
      if (swap)
        begin
          // First write operation.
          case (i_read_addr)
            0x00:
              begin
                s0x00_new = j_read_data;
                s0x00_we  = 1;
              end
          endcase // case (i_read_addr)
          
          if (j_read_addr != i_read_addr)
            begin
              case (j_read_addr)
                0x00:
                  begin
                    s0x00_new = i_read_data;
                    s0x00_we  = 1;
                  end
              endcase // case (i_read_addr)
            end
        end
    end // swap_bytes
    
endmodule // rc4_state_mem

//======================================================================
// EOF rc4_state_mem.v
//======================================================================
