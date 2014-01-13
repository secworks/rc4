//======================================================================
//
// rc4.v
// -----
// Verilog 2001 implementation of the RC4 stream cipher. The core
// supports key size from 8 to 256 bits and RFC4345 arcfour128,
// arcfour256 compliant initial keystream skipping.
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

module rc4(
           input wire          clk,
           input wire          reset_n,
           
           input wire          init,
           input wire          next,
           
           input wire [7 : 0]  key_byte,
           input wire [7 : 0]  key_address,
           input wire [4 : 0]  key_size,
           input wire          rfc4345_mode,
           
           output wire [7 : 0] keystream_byte,
           output wire         keystream_valid
          );
  
  
  //----------------------------------------------------------------
  // Internal constant and parameter definitions.
  //----------------------------------------------------------------
  
  
  //----------------------------------------------------------------
  // Registers including update variables and write enable.
  //----------------------------------------------------------------
  reg [7 : 0] ip_reg;
  reg [7 : 0] ip_new;
  reg         ip_we;

  reg [7 : 0] jp_reg;
  reg [7 : 0] jp_new;
  reg         jp_we;

  reg keystream_valid_reg;
  reg keystream_valid_new;
  reg keystream_valid_we;
  
  reg [1 : 0] rc4_ctrl_reg;
  reg [1 : 0] rc4_ctrl_new;
  reg         rc4_ctrl_we;

  
  //----------------------------------------------------------------
  // Wires.
  //----------------------------------------------------------------
              
  
  //----------------------------------------------------------------
  // Module instantiantions.
  //----------------------------------------------------------------

  
  //----------------------------------------------------------------
  // Concurrent connectivity for ports etc.
  //----------------------------------------------------------------
  assign keystream_valid = keystream_valid_reg;
  
  
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
          ip_reg       <= 8'h00;
          id_reg       <= 8'h00;
          jp_reg       <= 8'h00;
          jd_reg       <= 8'h00;
          rc4_ctrl_reg <= CTRL_IDLE;
        end
      else
        begin
          if (rc4_ctrl_we)
            begin
              rc4_ctrl_reg <= rc4_ctrl_new;
            end
        end
    end // reg_update

  
  //----------------------------------------------------------------
  // rc4_ctrl_fsm
  // Logic for the state machine controlling the core behaviour.
  //----------------------------------------------------------------
  always @*
    begin : rc4_ctrl_fsm
      sha256_ctrl_new  = CTRL_IDLE;
      sha256_ctrl_we   = 0;

      
      case (rc4_ctrl_reg)
        CTRL_IDLE:
          begin
          end
      endcase // case (rc4_ctrl_reg)
    end // rc4_ctrl_fsm
    
endmodule // rc4

//======================================================================
// EOF rc4.v
//======================================================================
