//======================================================================
//
// rc4_key_mem.v
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

module rc4_key_mem(
                   input wire          clk,
                   input wire          reset_n,

                   input wire          init,
                   
                   input wire  [4 : 0] key_write_addr,
                   input wire  [7 : 0] key_write_data,
                   input wire          key_write,
                   input wire          key_size,
                     
                   input wire  [4 : 0] key_read_addr,
                   output wire [7 : 0] key_read_data
                  );

  
  //----------------------------------------------------------------
  // Registers including update variables and write enable.
  //----------------------------------------------------------------
  reg [7 : 0] key_mem [0 : 31];

  reg  size_reg;

  
  //----------------------------------------------------------------
  // Wires.
  //----------------------------------------------------------------
  reg [7 : 0] tmp_key_read_data;
  

  //----------------------------------------------------------------
  // Concurrent connectivity for ports etc.
  //----------------------------------------------------------------
  assign key_read_data = tmp_key_read_data;

  
  //----------------------------------------------------------------
  // reg_update
  // Update functionality for all registers in the core.
  // All registers are positive edge triggered with asynchronous
  // active low reset. All registers have write enable.
  // Note that we don't reset the memory.
  //----------------------------------------------------------------
  always @ (posedge clk or negedge reset_n)
    begin : reg_update
      if (!reset_n)
        begin
          key_mem[00] <= 8'h00;
          key_mem[01] <= 8'h00;
          key_mem[02] <= 8'h00;
          key_mem[03] <= 8'h00;
          key_mem[04] <= 8'h00;
          key_mem[05] <= 8'h00;
          key_mem[06] <= 8'h00;
          key_mem[07] <= 8'h00;
          key_mem[08] <= 8'h00;
          key_mem[09] <= 8'h00;
          key_mem[10] <= 8'h00;
          key_mem[11] <= 8'h00;
          key_mem[12] <= 8'h00;
          key_mem[13] <= 8'h00;
          key_mem[14] <= 8'h00;
          key_mem[15] <= 8'h00;
          key_mem[16] <= 8'h00;
          key_mem[17] <= 8'h00;
          key_mem[18] <= 8'h00;
          key_mem[19] <= 8'h00;
          key_mem[20] <= 8'h00;
          key_mem[21] <= 8'h00;
          key_mem[22] <= 8'h00;
          key_mem[23] <= 8'h00;
          key_mem[24] <= 8'h00;
          key_mem[25] <= 8'h00;
          key_mem[26] <= 8'h00;
          key_mem[27] <= 8'h00;
          key_mem[28] <= 8'h00;
          key_mem[29] <= 8'h00;
          key_mem[30] <= 8'h00;
          key_mem[31] <= 8'h00;
          size_reg    <= 0;
        end
      else
        begin
          if (key_write)
            begin
              key_mem[key_write_addr] <= key_write_data;
            end
          
          if (init)
            begin
              size_reg <= key_size;
            end
        end
    end // reg_update

  
  //----------------------------------------------------------------
  // read_key_data
  //
  // The address used is modified based on the given key size 
  // before selecting the bits in the byte in the key mem.
  //----------------------------------------------------------------
  always @*
    begin : read_key_data
      reg [4 : 0] addr;

      if (size_reg)
        begin
          addr = key_read_addr;
        end
      else
        begin
          addr = {1'b0, key_read_addr[3 : 0]};
        end
      
      tmp_key_read_data = key_mem[addr];
    end // read_key_data

endmodule // rc4_key_mem

//======================================================================
// EOF rc4_key_mem.v
//======================================================================
