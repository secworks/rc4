//======================================================================
//
// rc4_core.v
// ----------
// Simple one-file implemenatation of the rc4 stream cipher.
// This implementation supports 128 or 256 bit keys.
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
                input wire            clk,
                input wire            reset_n,

                input wire            init,
                input wire            next,

                input wire  [255 : 0] key,
                input wire            keylen,

                output wire [7   : 0] keystream,
                output wire           ready
               );


  //----------------------------------------------------------------
  // Internal constant and parameter definitions.
  //----------------------------------------------------------------
  localparam CTRL_IDLE = 2'h0;
  localparam CTRL_INIT = 2'h1;
  localparam CTRL_KSA  = 2'h2;
  localparam CTRL_NEXT = 2'h3;


  //----------------------------------------------------------------
  // Registers including update variables and write enable.
  //----------------------------------------------------------------
  reg [7 : 0]  state [0 : 255];
  reg [7 : 0]  state_iaddr;
  reg [7 : 0]  state_inew;
  reg          state_iwe;
  reg [7 : 0]  state_jaddr;
  reg [7 : 0]  state_jnew;
  reg          state_jwe;

  reg [7 : 0]  ip_reg;
  reg [7 : 0]  ip_new;
  reg          ip_rst;
  reg          ip_nxt;
  reg          ip_we;

  reg [7 : 0]  jp_reg;
  reg [7 : 0]  jp_new;
  reg          jp_rst;
  reg          jp_nxt;
  reg          jp_we;

  reg          ready_reg;
  reg          ready_new;
  reg          ready_we;

  reg [1 : 0]  rc4_ctrl_reg;
  reg [1 : 0]  rc4_ctrl_new;
  reg          rc4_ctrl_we;


  //----------------------------------------------------------------
  // Wires.
  //----------------------------------------------------------------
  reg         init_state;
  reg         update_state;
  reg         ksa_mode;
  reg [7 : 0] kdata;
  reg         kdata_en;

  //----------------------------------------------------------------
  // Concurrent connectivity for ports etc.
  //----------------------------------------------------------------
  assign keystream = kdata;
  assign ready     = ready_reg;


  //----------------------------------------------------------------
  // reg_update.
  //----------------------------------------------------------------
  always @ (posedge clk)
    begin: reg_update
      integer i;

      if (!reset_n) begin
        for (i = 0 ; i < 256 ; i = i + 1) begin
          state[i] <= 8'h0;
        end

        ip_reg       <= 8'h0;
        jp_reg       <= 8'h0;
        ready_reg    <= 1'h0;
        rc4_ctrl_reg <= CTRL_IDLE;
      end

      else begin
        if (ip_we)
          ip_reg <= ip_new;

        if (jp_we)
          jp_reg <= jp_new;

        if (state_iwe)
          state[state_iaddr] <= state_inew;

        if (state_jwe)
          state[state_jaddr] <= state_jnew;

        if (ready_we)
          ready_reg <= ready_new;

        if (rc4_ctrl_we)
          rc4_ctrl_reg <= rc4_ctrl_new;
      end
    end // reg_update


  //----------------------------------------------------------------
  // rc4_core_logic.
  //----------------------------------------------------------------
  always @*
    begin : rc4_core_logic
      reg [7 : 0] istate;
      reg [7 : 0] jstate;
      reg [4 : 0] key_addr;
      reg [7 : 0] key_byte;
      reg [7 : 0] kp;

      ip_new      = 8'h0;
      ip_we       = 1'h0;
      jp_new      = 8'h0;
      jp_we       = 1'h0;
      state_iwe   = 1'h0;
      state_inew  = 8'h0;
      state_iaddr = 8'h0;
      state_jwe   = 1'h0;
      state_jnew  = 8'h0;
      state_jaddr = 8'h0;
      kdata       = 8'h0;


      if (keylen) begin
        key_addr = ip_reg[4 : 0];
      end
      else begin
        key_addr = {1'h0, ip_reg[3 : 0]};
      end
      key_byte = key[key_addr * 8 +: 8];


      if (ip_rst) begin
        ip_new = 8'h0;
        ip_we  = 1'h1;
      end

      if (ip_nxt) begin
        ip_new = ip_reg + 1'h1;
        ip_we  = 1'h1;
      end
      istate = state[ip_new];


      if (jp_rst) begin
        jp_new = 8'h0;
        jp_we  = 1'h1;
      end

      if (jp_nxt) begin
        jp_we  = 1'h1;
        if (ksa_mode) begin
          jp_new = jp_reg + istate + key_byte;
        end
        else begin
          jp_new = jp_reg + istate;
        end
      end
      jstate = state[jp_new];


      if (init_state) begin
        state_inew  = ip_reg;
        state_iaddr = ip_reg;
        state_iwe   = 1'h1;
      end

      if (update_state) begin
        state_inew  = jstate;
        state_iaddr = ip_new;
        state_iwe   = 1'h1;

        state_jnew  = istate;
        state_jaddr = jp_new;
        state_jwe   = 1'h1;
      end


      kp = istate + jstate;
      if (kdata_en)
        kdata = state[kp];
    end


  //----------------------------------------------------------------
  // rc4_ctrl.
  //----------------------------------------------------------------
  always @*
    begin : rc4_ctrl
      init_state   = 1'h0;
      update_state = 1'h0;
      ready_new    = 1'h0;
      ready_we     = 1'h0;
      ip_rst       = 1'h0;
      ip_nxt       = 1'h0;
      jp_rst       = 1'h0;
      jp_nxt       = 1'h0;
      ksa_mode     = 1'h0;
      init_state   = 1'h0;
      update_state = 1'h0;
      kdata_en     = 1'h0;
      rc4_ctrl_new = CTRL_IDLE;
      rc4_ctrl_we  = 1'h0;

      case (rc4_ctrl_reg)
        CTRL_IDLE : begin
          if (init) begin
            ip_rst       = 1'h1;
            jp_rst       = 1'h1;
            init_state   = 1'h1;
            ready_new    = 1'h0;
            ready_we     = 1'h1;
            rc4_ctrl_new = CTRL_INIT;
            rc4_ctrl_we  = 1'h1;
          end

          if (next) begin
            rc4_ctrl_new = CTRL_NEXT;
            rc4_ctrl_we  = 1'h1;
          end
        end


        CTRL_INIT : begin
          init_state = 1'h1;
          ip_nxt     = 1'h1;

          if (ip_new == 8'h0) begin
            rc4_ctrl_new = CTRL_KSA;
            rc4_ctrl_we  = 1'h1;
          end
        end


        CTRL_KSA : begin
          ip_nxt       = 1'h1;
          jp_nxt       = 1'h1;
          ksa_mode     = 1'h1;
          update_state = 1'h1;

          if (ip_new == 8'h0) begin
            ready_new    = 1'h1;
            ready_we     = 1'h1;
            rc4_ctrl_new = CTRL_IDLE;
            rc4_ctrl_we  = 1'h1;
          end
        end


        CTRL_NEXT : begin
          ready_new    = 1'h1;
          ready_we     = 1'h1;
          rc4_ctrl_new = CTRL_IDLE;
          rc4_ctrl_we  = 1'h1;
        end

        default : begin
        end
      endcase // case (rc4_ctrl_reg)
    end

endmodule // rc4_core


//======================================================================
// EOF rc4_core.v
//======================================================================
