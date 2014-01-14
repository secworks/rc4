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

        default:
          begin
            tmp_key_data = 8'h00;
          end
      endcase // case (addr)
      
    end // read_key_data
endmodule // rc4_key_mem

//======================================================================
// EOF rc4_key_mem.v
//======================================================================
