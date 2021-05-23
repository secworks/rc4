//======================================================================
//
// rc4_core.v
// ----------
// Simple on-file implemenatation of the rc4 stream cipher.
//
//
// Author: Joachim Strombergson
// Copyright (c) 2021.
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

`default_nettype none

module rc4_core(
                input wire           clk,
                input wire           reset_n,

                input wire           init,
                input wire           next,

                input wire  [255 : 0] key,
                input wire  [4   : 0] keylen,

                output wire [7   : 0] keystream
               );


  //----------------------------------------------------------------
  // Internal constant and parameter definitions.
  //----------------------------------------------------------------
  localparam CTRL_IDLE = 3'h0;
  localparam CTRL_INIT = 3'h1;
  localparam CTRL_NEXT = 3'h2;



  //----------------------------------------------------------------
  // Registers including update variables and write enable.
  //----------------------------------------------------------------
  reg [7 : 0]  state [0 : 255];
  reg [7 : 0]  state_new;
  reg [7 : 0]  state_ptr;
  reg          state_we;

  reg [7 : 0]  ip_reg;
  reg [7 : 0]  ip_new;
  reg          ip_we;

  reg [7 : 0]  jp_reg;
  reg [7 : 0]  jp_new;
  reg          jp_we;

  reg [2 : 0]  rc4_ctrl_reg;
  reg [2 : 0]  rc4_ctrl_new;
  reg          rc4_ctrl_we;


  //----------------------------------------------------------------
  // Wires.
  //----------------------------------------------------------------
  reg init_state;
  reg update_state;


  //----------------------------------------------------------------
  // Concurrent connectivity for ports etc.
  //----------------------------------------------------------------
  assign keystream = 8'haa;


  //----------------------------------------------------------------
  // reg_update
  //
  // Update functionality for all registers in the core.
  // All registers are positive edge triggered, and with
  // synchronous active low reset.
  //----------------------------------------------------------------
  always @ (posedge clk)
    begin: reg_update
      integer i;

      if (!reset_n)
        begin
          for (i = 0 ; i < 256 ; i = i + 1)
            state[i] <= 8'h0;

          ip_reg       <= 8'h0;
          jp_reg       <= 8'h0;
          rc4_ctrl_reg <= CTRL_IDLE;
        end
      else
        begin
          if (ip_we)
            ip_reg <= ip_new;

          if (jp_we)
            jp_reg <= jp_new;

          if (state_we)
            state[state_ptr] <= state_new;

          if (rc4_ctrl_we)
            rc4_ctrl_reg <= rc4_ctrl_new;
        end
    end // reg_update


  //----------------------------------------------------------------
  // rc4_logic.
  //----------------------------------------------------------------
  always @*
    begin : rc4_logic
      reg [7 : 0] id;
      reg [7 : 0] jd;
      reg [7 : 0] kp;
      reg [7 : 0] kp;

      state_new = 8'h0;
      state_ptr = 8'h0;
      state_we  = 1'h0;

      ip_new    = 8'h0;
      ip_we     = 1'h0;


      if (init_state) begin
        state_new = ip_reg;
        state_ptr = ip_reg;
        state_we  = 1'h1;
        ip_new    = ip_reg + 1'h1;
        ip_we     = 1'h1;
      end

      if (update_state) begin

      end
    end


  //----------------------------------------------------------------
  // rc4_ctrl
  // FSM logic that controls the r4 functionality.
  //----------------------------------------------------------------
  always @*
    begin : rc4_ctrl
      init_state = 1'h0;

    end

endmodule // rc4_core


//======================================================================
// EOF rc4_core.v
//======================================================================
