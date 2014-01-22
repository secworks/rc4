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
  reg [7 : 0]state_mem[0 : 255];
  
  
  //----------------------------------------------------------------
  // Wires.
  //----------------------------------------------------------------
  reg [7 : 0] tmp_i_data;
  reg [7 : 0] tmp_j_data;
  reg [7 : 0] tmp_k_data;


  //----------------------------------------------------------------
  // Concurrent assignments.
  //----------------------------------------------------------------
  assign i_read_data = tmp_i_data;
  assign j_read_data = tmp_j_data;
  assign k_read_data = tmp_k_data;

  
  //----------------------------------------------------------------
  // reg_update
  // Update functionality for all registers in the core.
  // All registers are positive edge triggered with synchronous
  // active low reset. All registers have write enable.
  //----------------------------------------------------------------
  always @ (posedge clk)
    begin : reg_update
      if ((!reset_n) || (init))
        begin
          state_mem[8'h00] <= 8'h00;
          state_mem[8'h01] <= 8'h01;
          state_mem[8'h02] <= 8'h02;
          state_mem[8'h03] <= 8'h03;
          state_mem[8'h04] <= 8'h04;
          state_mem[8'h05] <= 8'h05;
          state_mem[8'h06] <= 8'h06;
          state_mem[8'h07] <= 8'h07;
          state_mem[8'h08] <= 8'h08;
          state_mem[8'h09] <= 8'h09;
          state_mem[8'h0a] <= 8'h0a;
          state_mem[8'h0b] <= 8'h0b;
          state_mem[8'h0c] <= 8'h0c;
          state_mem[8'h0d] <= 8'h0d;
          state_mem[8'h0e] <= 8'h0e;
          state_mem[8'h0f] <= 8'h0f;
          state_mem[8'h10] <= 8'h10;
          state_mem[8'h11] <= 8'h11;
          state_mem[8'h12] <= 8'h12;
          state_mem[8'h13] <= 8'h13;
          state_mem[8'h14] <= 8'h14;
          state_mem[8'h15] <= 8'h15;
          state_mem[8'h16] <= 8'h16;
          state_mem[8'h17] <= 8'h17;
          state_mem[8'h18] <= 8'h18;
          state_mem[8'h19] <= 8'h19;
          state_mem[8'h1a] <= 8'h1a;
          state_mem[8'h1b] <= 8'h1b;
          state_mem[8'h1c] <= 8'h1c;
          state_mem[8'h1d] <= 8'h1d;
          state_mem[8'h1e] <= 8'h1e;
          state_mem[8'h1f] <= 8'h1f;
          state_mem[8'h20] <= 8'h20;
          state_mem[8'h21] <= 8'h21;
          state_mem[8'h22] <= 8'h22;
          state_mem[8'h23] <= 8'h23;
          state_mem[8'h24] <= 8'h24;
          state_mem[8'h25] <= 8'h25;
          state_mem[8'h26] <= 8'h26;
          state_mem[8'h27] <= 8'h27;
          state_mem[8'h28] <= 8'h28;
          state_mem[8'h29] <= 8'h29;
          state_mem[8'h2a] <= 8'h2a;
          state_mem[8'h2b] <= 8'h2b;
          state_mem[8'h2c] <= 8'h2c;
          state_mem[8'h2d] <= 8'h2d;
          state_mem[8'h2e] <= 8'h2e;
          state_mem[8'h2f] <= 8'h2f;
          state_mem[8'h30] <= 8'h30;
          state_mem[8'h31] <= 8'h31;
          state_mem[8'h32] <= 8'h32;
          state_mem[8'h33] <= 8'h33;
          state_mem[8'h34] <= 8'h34;
          state_mem[8'h35] <= 8'h35;
          state_mem[8'h36] <= 8'h36;
          state_mem[8'h37] <= 8'h37;
          state_mem[8'h38] <= 8'h38;
          state_mem[8'h39] <= 8'h39;
          state_mem[8'h3a] <= 8'h3a;
          state_mem[8'h3b] <= 8'h3b;
          state_mem[8'h3c] <= 8'h3c;
          state_mem[8'h3d] <= 8'h3d;
          state_mem[8'h3e] <= 8'h3e;
          state_mem[8'h3f] <= 8'h3f;
          state_mem[8'h40] <= 8'h40;
          state_mem[8'h41] <= 8'h41;
          state_mem[8'h42] <= 8'h42;
          state_mem[8'h43] <= 8'h43;
          state_mem[8'h44] <= 8'h44;
          state_mem[8'h45] <= 8'h45;
          state_mem[8'h46] <= 8'h46;
          state_mem[8'h47] <= 8'h47;
          state_mem[8'h48] <= 8'h48;
          state_mem[8'h49] <= 8'h49;
          state_mem[8'h4a] <= 8'h4a;
          state_mem[8'h4b] <= 8'h4b;
          state_mem[8'h4c] <= 8'h4c;
          state_mem[8'h4d] <= 8'h4d;
          state_mem[8'h4e] <= 8'h4e;
          state_mem[8'h4f] <= 8'h4f;
          state_mem[8'h50] <= 8'h50;
          state_mem[8'h51] <= 8'h51;
          state_mem[8'h52] <= 8'h52;
          state_mem[8'h53] <= 8'h53;
          state_mem[8'h54] <= 8'h54;
          state_mem[8'h55] <= 8'h55;
          state_mem[8'h56] <= 8'h56;
          state_mem[8'h57] <= 8'h57;
          state_mem[8'h58] <= 8'h58;
          state_mem[8'h59] <= 8'h59;
          state_mem[8'h5a] <= 8'h5a;
          state_mem[8'h5b] <= 8'h5b;
          state_mem[8'h5c] <= 8'h5c;
          state_mem[8'h5d] <= 8'h5d;
          state_mem[8'h5e] <= 8'h5e;
          state_mem[8'h5f] <= 8'h5f;
          state_mem[8'h60] <= 8'h60;
          state_mem[8'h61] <= 8'h61;
          state_mem[8'h62] <= 8'h62;
          state_mem[8'h63] <= 8'h63;
          state_mem[8'h64] <= 8'h64;
          state_mem[8'h65] <= 8'h65;
          state_mem[8'h66] <= 8'h66;
          state_mem[8'h67] <= 8'h67;
          state_mem[8'h68] <= 8'h68;
          state_mem[8'h69] <= 8'h69;
          state_mem[8'h6a] <= 8'h6a;
          state_mem[8'h6b] <= 8'h6b;
          state_mem[8'h6c] <= 8'h6c;
          state_mem[8'h6d] <= 8'h6d;
          state_mem[8'h6e] <= 8'h6e;
          state_mem[8'h6f] <= 8'h6f;
          state_mem[8'h70] <= 8'h70;
          state_mem[8'h71] <= 8'h71;
          state_mem[8'h72] <= 8'h72;
          state_mem[8'h73] <= 8'h73;
          state_mem[8'h74] <= 8'h74;
          state_mem[8'h75] <= 8'h75;
          state_mem[8'h76] <= 8'h76;
          state_mem[8'h77] <= 8'h77;
          state_mem[8'h78] <= 8'h78;
          state_mem[8'h79] <= 8'h79;
          state_mem[8'h7a] <= 8'h7a;
          state_mem[8'h7b] <= 8'h7b;
          state_mem[8'h7c] <= 8'h7c;
          state_mem[8'h7d] <= 8'h7d;
          state_mem[8'h7e] <= 8'h7e;
          state_mem[8'h7f] <= 8'h7f;
          state_mem[8'h80] <= 8'h80;
          state_mem[8'h81] <= 8'h81;
          state_mem[8'h82] <= 8'h82;
          state_mem[8'h83] <= 8'h83;
          state_mem[8'h84] <= 8'h84;
          state_mem[8'h85] <= 8'h85;
          state_mem[8'h86] <= 8'h86;
          state_mem[8'h87] <= 8'h87;
          state_mem[8'h88] <= 8'h88;
          state_mem[8'h89] <= 8'h89;
          state_mem[8'h8a] <= 8'h8a;
          state_mem[8'h8b] <= 8'h8b;
          state_mem[8'h8c] <= 8'h8c;
          state_mem[8'h8d] <= 8'h8d;
          state_mem[8'h8e] <= 8'h8e;
          state_mem[8'h8f] <= 8'h8f;
          state_mem[8'h90] <= 8'h90;
          state_mem[8'h91] <= 8'h91;
          state_mem[8'h92] <= 8'h92;
          state_mem[8'h93] <= 8'h93;
          state_mem[8'h94] <= 8'h94;
          state_mem[8'h95] <= 8'h95;
          state_mem[8'h96] <= 8'h96;
          state_mem[8'h97] <= 8'h97;
          state_mem[8'h98] <= 8'h98;
          state_mem[8'h99] <= 8'h99;
          state_mem[8'h9a] <= 8'h9a;
          state_mem[8'h9b] <= 8'h9b;
          state_mem[8'h9c] <= 8'h9c;
          state_mem[8'h9d] <= 8'h9d;
          state_mem[8'h9e] <= 8'h9e;
          state_mem[8'h9f] <= 8'h9f;
          state_mem[8'ha0] <= 8'ha0;
          state_mem[8'ha1] <= 8'ha1;
          state_mem[8'ha2] <= 8'ha2;
          state_mem[8'ha3] <= 8'ha3;
          state_mem[8'ha4] <= 8'ha4;
          state_mem[8'ha5] <= 8'ha5;
          state_mem[8'ha6] <= 8'ha6;
          state_mem[8'ha7] <= 8'ha7;
          state_mem[8'ha8] <= 8'ha8;
          state_mem[8'ha9] <= 8'ha9;
          state_mem[8'haa] <= 8'haa;
          state_mem[8'hab] <= 8'hab;
          state_mem[8'hac] <= 8'hac;
          state_mem[8'had] <= 8'had;
          state_mem[8'hae] <= 8'hae;
          state_mem[8'haf] <= 8'haf;
          state_mem[8'hb0] <= 8'hb0;
          state_mem[8'hb1] <= 8'hb1;
          state_mem[8'hb2] <= 8'hb2;
          state_mem[8'hb3] <= 8'hb3;
          state_mem[8'hb4] <= 8'hb4;
          state_mem[8'hb5] <= 8'hb5;
          state_mem[8'hb6] <= 8'hb6;
          state_mem[8'hb7] <= 8'hb7;
          state_mem[8'hb8] <= 8'hb8;
          state_mem[8'hb9] <= 8'hb9;
          state_mem[8'hba] <= 8'hba;
          state_mem[8'hbb] <= 8'hbb;
          state_mem[8'hbc] <= 8'hbc;
          state_mem[8'hbd] <= 8'hbd;
          state_mem[8'hbe] <= 8'hbe;
          state_mem[8'hbf] <= 8'hbf;
          state_mem[8'hc0] <= 8'hc0;
          state_mem[8'hc1] <= 8'hc1;
          state_mem[8'hc2] <= 8'hc2;
          state_mem[8'hc3] <= 8'hc3;
          state_mem[8'hc4] <= 8'hc4;
          state_mem[8'hc5] <= 8'hc5;
          state_mem[8'hc6] <= 8'hc6;
          state_mem[8'hc7] <= 8'hc7;
          state_mem[8'hc8] <= 8'hc8;
          state_mem[8'hc9] <= 8'hc9;
          state_mem[8'hca] <= 8'hca;
          state_mem[8'hcb] <= 8'hcb;
          state_mem[8'hcc] <= 8'hcc;
          state_mem[8'hcd] <= 8'hcd;
          state_mem[8'hce] <= 8'hce;
          state_mem[8'hcf] <= 8'hcf;
          state_mem[8'hd0] <= 8'hd0;
          state_mem[8'hd1] <= 8'hd1;
          state_mem[8'hd2] <= 8'hd2;
          state_mem[8'hd3] <= 8'hd3;
          state_mem[8'hd4] <= 8'hd4;
          state_mem[8'hd5] <= 8'hd5;
          state_mem[8'hd6] <= 8'hd6;
          state_mem[8'hd7] <= 8'hd7;
          state_mem[8'hd8] <= 8'hd8;
          state_mem[8'hd9] <= 8'hd9;
          state_mem[8'hda] <= 8'hda;
          state_mem[8'hdb] <= 8'hdb;
          state_mem[8'hdc] <= 8'hdc;
          state_mem[8'hdd] <= 8'hdd;
          state_mem[8'hde] <= 8'hde;
          state_mem[8'hdf] <= 8'hdf;
          state_mem[8'he0] <= 8'he0;
          state_mem[8'he1] <= 8'he1;
          state_mem[8'he2] <= 8'he2;
          state_mem[8'he3] <= 8'he3;
          state_mem[8'he4] <= 8'he4;
          state_mem[8'he5] <= 8'he5;
          state_mem[8'he6] <= 8'he6;
          state_mem[8'he7] <= 8'he7;
          state_mem[8'he8] <= 8'he8;
          state_mem[8'he9] <= 8'he9;
          state_mem[8'hea] <= 8'hea;
          state_mem[8'heb] <= 8'heb;
          state_mem[8'hec] <= 8'hec;
          state_mem[8'hed] <= 8'hed;
          state_mem[8'hee] <= 8'hee;
          state_mem[8'hef] <= 8'hef;
          state_mem[8'hf0] <= 8'hf0;
          state_mem[8'hf1] <= 8'hf1;
          state_mem[8'hf2] <= 8'hf2;
          state_mem[8'hf3] <= 8'hf3;
          state_mem[8'hf4] <= 8'hf4;
          state_mem[8'hf5] <= 8'hf5;
          state_mem[8'hf6] <= 8'hf6;
          state_mem[8'hf7] <= 8'hf7;
          state_mem[8'hf8] <= 8'hf8;
          state_mem[8'hf9] <= 8'hf9;
          state_mem[8'hfa] <= 8'hfa;
          state_mem[8'hfb] <= 8'hfb;
          state_mem[8'hfc] <= 8'hfc;
          state_mem[8'hfd] <= 8'hfd;
          state_mem[8'hfe] <= 8'hfe;
          state_mem[8'hff] <= 8'hff;
        end
      else
        begin
          if (swap)
            begin
              state_mem[i_read_addr] = tmp_j_data;
              state_mem[j_read_addr] = tmp_i_data;
            end
        end
    end // reg_update


  //----------------------------------------------------------------
  // read_mem
  //----------------------------------------------------------------
  always @*
    begin : read_mem
      tmp_i_data = state_mem[i_read_addr];
      tmp_j_data = state_mem[j_read_addr];
      tmp_k_data = state_mem[k_read_addr];
    end
  
endmodule // rc4_state_mem

//======================================================================
// EOF rc4_state_mem.v
//======================================================================
