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
                   input wire            clk,
                   input wire            reset_n,
                     
                   input wire            init,

                   input wire  [255 : 0] key,
                   input wire            key_size,
                     
                   input wire  [7 : 0]   key_addr,
                   output wire [7 : 0]   key_data
                  );

  
  //----------------------------------------------------------------
  // Registers including update variables and write enable.
  //----------------------------------------------------------------
  reg [255 : 0] key_reg;
  reg           size;

  
  //----------------------------------------------------------------
  // Wires.
  //----------------------------------------------------------------
  reg [7 : 0] ]tmp_key_data;
  

  //----------------------------------------------------------------
  // Concurrent connectivity for ports etc.
  //----------------------------------------------------------------
  assign key_data = tmp_key_data;

  
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
          key_reg <= 256'h0000000000000000000000000000000000000000000000000000000000000000;
          size <= 0;
        end
      else
        begin
          if (init)
            begin
              key_reg <= key;
              size = key_size;
            end
        end
    end // reg_update


  //----------------------------------------------------------------
  // read_key_data
  //
  // Address mux. The address used is modified based on
  // the given key size before selecting the bits in the key
  // register.
  //----------------------------------------------------------------
  always @*
    begin : read_key_data
      reg [7 : 0] addr;
      
      if (size)
        begin
          addr = key_addr;
        end
      else
        begin
          addr = {1'b0, key_addr[6 : 0]};
        end

      case (addr)
        0x00:
          begin
            tmp_key_data = key_reg[255 : 248];
          end

        0x01:
          begin
            tmp_key_data = key_reg[247 : 240];
          end

        0x02:
          begin
            tmp_key_data = key_reg[239 : 232];
          end

        0x03:
          begin
            tmp_key_data = key_reg[231 : 224];
          end

        0x04:
          begin
            tmp_key_data = key_reg[223 : 216];
          end

        0x05:
          begin
            tmp_key_data = key_reg[215 : 208];
          end

        0x06:
          begin
            tmp_key_data = key_reg[207 : 200];
          end

        0x07:
          begin
            tmp_key_data = key_reg[199 : 192];
          end

        0x08:
          begin
            tmp_key_data = key_reg[191 : 184];
          end

        0x09:
          begin
            tmp_key_data = key_reg[183 : 176];
          end

        0x0a:
          begin
            tmp_key_data = key_reg[175 : 168];
          end

        0x0b:
          begin
            tmp_key_data = key_reg[167 : 160];
          end

        0x0c:
          begin
            tmp_key_data = key_reg[159 : 152];
          end

        0x0d:
          begin
            tmp_key_data = key_reg[151 : 144];
          end

        0x0e:
          begin
            tmp_key_data = key_reg[143 : 136];
          end

        0x0f:
          begin
            tmp_key_data = key_reg[135 : 128];
          end

        0x10:
          begin
            tmp_key_data = key_reg[127 : 120];
          end

        0x11:
          begin
            tmp_key_data = key_reg[119 : 112];
          end

        0x12:
          begin
            tmp_key_data = key_reg[111 : 104];
          end

        0x13:
          begin
            tmp_key_data = key_reg[103 : 096];
          end

        0x14:
          begin
            tmp_key_data = key_reg[095 : 088];
          end

        0x15:
          begin
            tmp_key_data = key_reg[087 : 080];
          end

        0x16:
          begin
            tmp_key_data = key_reg[079 : 072];
          end

        0x17:
          begin
            tmp_key_data = key_reg[071 : 064];
          end

        0x18:
          begin
            tmp_key_data = key_reg[063 : 056];
          end

        0x19:
          begin
            tmp_key_data = key_reg[055 : 048];
          end

        0x1a:
          begin
            tmp_key_data = key_reg[047 : 040];
          end

        0x1b:
          begin
            tmp_key_data = key_reg[039 : 032];
          end

        0x1c:
          begin
            tmp_key_data = key_reg[031 : 024];
          end

        0x1d:
          begin
            tmp_key_data = key_reg[023 : 016];
          end

        0x1e:
          begin
            tmp_key_data = key_reg[015 : 008];
          end

        0x1f:
          begin
            tmp_key_data = key_reg[007 : 000];
          end
      endcase // case (addr)
    end // read_key_data

endmodule // rc4_key_mem

//======================================================================
// EOF rc4_key_mem.v
//======================================================================
