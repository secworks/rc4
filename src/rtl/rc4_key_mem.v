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
            tmp_key_data = 0x00;
          end

        0x01:
          begin
            tmp_key_data = 0x01;
          end

        0x02:
          begin
            tmp_key_data = 0x02;
          end

        0x03:
          begin
            tmp_key_data = 0x03;
          end

        0x04:
          begin
            tmp_key_data = 0x04;
          end

        0x05:
          begin
            tmp_key_data = 0x05;
          end

        0x06:
          begin
            tmp_key_data = 0x06;
          end

        0x07:
          begin
            tmp_key_data = 0x07;
          end

        0x08:
          begin
            tmp_key_data = 0x08;
          end

        0x09:
          begin
            tmp_key_data = 0x09;
          end

        0x0a:
          begin
            tmp_key_data = 0x0a;
          end

        0x0b:
          begin
            tmp_key_data = 0x0b;
          end

        0x0c:
          begin
            tmp_key_data = 0x0c;
          end

        0x0d:
          begin
            tmp_key_data = 0x0d;
          end

        0x0e:
          begin
            tmp_key_data = 0x0e;
          end

        0x0f:
          begin
            tmp_key_data = 0x0f;
          end

        0x10:
          begin
            tmp_key_data = 0x10;
          end

        0x11:
          begin
            tmp_key_data = 0x11;
          end

        0x12:
          begin
            tmp_key_data = 0x12;
          end

        0x13:
          begin
            tmp_key_data = 0x13;
          end

        0x14:
          begin
            tmp_key_data = 0x14;
          end

        0x15:
          begin
            tmp_key_data = 0x15;
          end

        0x16:
          begin
            tmp_key_data = 0x16;
          end

        0x17:
          begin
            tmp_key_data = 0x17;
          end

        0x18:
          begin
            tmp_key_data = 0x18;
          end

        0x19:
          begin
            tmp_key_data = 0x19;
          end

        0x1a:
          begin
            tmp_key_data = 0x1a;
          end

        0x1b:
          begin
            tmp_key_data = 0x1b;
          end

        0x1c:
          begin
            tmp_key_data = 0x1c;
          end

        0x1d:
          begin
            tmp_key_data = 0x1d;
          end

        0x1e:
          begin
            tmp_key_data = 0x1e;
          end

        0x1f:
          begin
            tmp_key_data = 0x1f;
          end

        0x20:
          begin
            tmp_key_data = 0x20;
          end

        0x21:
          begin
            tmp_key_data = 0x21;
          end

        0x22:
          begin
            tmp_key_data = 0x22;
          end

        0x23:
          begin
            tmp_key_data = 0x23;
          end

        0x24:
          begin
            tmp_key_data = 0x24;
          end

        0x25:
          begin
            tmp_key_data = 0x25;
          end

        0x26:
          begin
            tmp_key_data = 0x26;
          end

        0x27:
          begin
            tmp_key_data = 0x27;
          end

        0x28:
          begin
            tmp_key_data = 0x28;
          end

        0x29:
          begin
            tmp_key_data = 0x29;
          end

        0x2a:
          begin
            tmp_key_data = 0x2a;
          end

        0x2b:
          begin
            tmp_key_data = 0x2b;
          end

        0x2c:
          begin
            tmp_key_data = 0x2c;
          end

        0x2d:
          begin
            tmp_key_data = 0x2d;
          end

        0x2e:
          begin
            tmp_key_data = 0x2e;
          end

        0x2f:
          begin
            tmp_key_data = 0x2f;
          end

        0x30:
          begin
            tmp_key_data = 0x30;
          end

        0x31:
          begin
            tmp_key_data = 0x31;
          end

        0x32:
          begin
            tmp_key_data = 0x32;
          end

        0x33:
          begin
            tmp_key_data = 0x33;
          end

        0x34:
          begin
            tmp_key_data = 0x34;
          end

        0x35:
          begin
            tmp_key_data = 0x35;
          end

        0x36:
          begin
            tmp_key_data = 0x36;
          end

        0x37:
          begin
            tmp_key_data = 0x37;
          end

        0x38:
          begin
            tmp_key_data = 0x38;
          end

        0x39:
          begin
            tmp_key_data = 0x39;
          end

        0x3a:
          begin
            tmp_key_data = 0x3a;
          end

        0x3b:
          begin
            tmp_key_data = 0x3b;
          end

        0x3c:
          begin
            tmp_key_data = 0x3c;
          end

        0x3d:
          begin
            tmp_key_data = 0x3d;
          end

        0x3e:
          begin
            tmp_key_data = 0x3e;
          end

        0x3f:
          begin
            tmp_key_data = 0x3f;
          end

        0x40:
          begin
            tmp_key_data = 0x40;
          end

        0x41:
          begin
            tmp_key_data = 0x41;
          end

        0x42:
          begin
            tmp_key_data = 0x42;
          end

        0x43:
          begin
            tmp_key_data = 0x43;
          end

        0x44:
          begin
            tmp_key_data = 0x44;
          end

        0x45:
          begin
            tmp_key_data = 0x45;
          end

        0x46:
          begin
            tmp_key_data = 0x46;
          end

        0x47:
          begin
            tmp_key_data = 0x47;
          end

        0x48:
          begin
            tmp_key_data = 0x48;
          end

        0x49:
          begin
            tmp_key_data = 0x49;
          end

        0x4a:
          begin
            tmp_key_data = 0x4a;
          end

        0x4b:
          begin
            tmp_key_data = 0x4b;
          end

        0x4c:
          begin
            tmp_key_data = 0x4c;
          end

        0x4d:
          begin
            tmp_key_data = 0x4d;
          end

        0x4e:
          begin
            tmp_key_data = 0x4e;
          end

        0x4f:
          begin
            tmp_key_data = 0x4f;
          end

        0x50:
          begin
            tmp_key_data = 0x50;
          end

        0x51:
          begin
            tmp_key_data = 0x51;
          end

        0x52:
          begin
            tmp_key_data = 0x52;
          end

        0x53:
          begin
            tmp_key_data = 0x53;
          end

        0x54:
          begin
            tmp_key_data = 0x54;
          end

        0x55:
          begin
            tmp_key_data = 0x55;
          end

        0x56:
          begin
            tmp_key_data = 0x56;
          end

        0x57:
          begin
            tmp_key_data = 0x57;
          end

        0x58:
          begin
            tmp_key_data = 0x58;
          end

        0x59:
          begin
            tmp_key_data = 0x59;
          end

        0x5a:
          begin
            tmp_key_data = 0x5a;
          end

        0x5b:
          begin
            tmp_key_data = 0x5b;
          end

        0x5c:
          begin
            tmp_key_data = 0x5c;
          end

        0x5d:
          begin
            tmp_key_data = 0x5d;
          end

        0x5e:
          begin
            tmp_key_data = 0x5e;
          end

        0x5f:
          begin
            tmp_key_data = 0x5f;
          end

        0x60:
          begin
            tmp_key_data = 0x60;
          end

        0x61:
          begin
            tmp_key_data = 0x61;
          end

        0x62:
          begin
            tmp_key_data = 0x62;
          end

        0x63:
          begin
            tmp_key_data = 0x63;
          end

        0x64:
          begin
            tmp_key_data = 0x64;
          end

        0x65:
          begin
            tmp_key_data = 0x65;
          end

        0x66:
          begin
            tmp_key_data = 0x66;
          end

        0x67:
          begin
            tmp_key_data = 0x67;
          end

        0x68:
          begin
            tmp_key_data = 0x68;
          end

        0x69:
          begin
            tmp_key_data = 0x69;
          end

        0x6a:
          begin
            tmp_key_data = 0x6a;
          end

        0x6b:
          begin
            tmp_key_data = 0x6b;
          end

        0x6c:
          begin
            tmp_key_data = 0x6c;
          end

        0x6d:
          begin
            tmp_key_data = 0x6d;
          end

        0x6e:
          begin
            tmp_key_data = 0x6e;
          end

        0x6f:
          begin
            tmp_key_data = 0x6f;
          end

        0x70:
          begin
            tmp_key_data = 0x70;
          end

        0x71:
          begin
            tmp_key_data = 0x71;
          end

        0x72:
          begin
            tmp_key_data = 0x72;
          end

        0x73:
          begin
            tmp_key_data = 0x73;
          end

        0x74:
          begin
            tmp_key_data = 0x74;
          end

        0x75:
          begin
            tmp_key_data = 0x75;
          end

        0x76:
          begin
            tmp_key_data = 0x76;
          end

        0x77:
          begin
            tmp_key_data = 0x77;
          end

        0x78:
          begin
            tmp_key_data = 0x78;
          end

        0x79:
          begin
            tmp_key_data = 0x79;
          end

        0x7a:
          begin
            tmp_key_data = 0x7a;
          end

        0x7b:
          begin
            tmp_key_data = 0x7b;
          end

        0x7c:
          begin
            tmp_key_data = 0x7c;
          end

        0x7d:
          begin
            tmp_key_data = 0x7d;
          end

        0x7e:
          begin
            tmp_key_data = 0x7e;
          end

        0x7f:
          begin
            tmp_key_data = 0x7f;
          end

        0x80:
          begin
            tmp_key_data = 0x80;
          end

        0x81:
          begin
            tmp_key_data = 0x81;
          end

        0x82:
          begin
            tmp_key_data = 0x82;
          end

        0x83:
          begin
            tmp_key_data = 0x83;
          end

        0x84:
          begin
            tmp_key_data = 0x84;
          end

        0x85:
          begin
            tmp_key_data = 0x85;
          end

        0x86:
          begin
            tmp_key_data = 0x86;
          end

        0x87:
          begin
            tmp_key_data = 0x87;
          end

        0x88:
          begin
            tmp_key_data = 0x88;
          end

        0x89:
          begin
            tmp_key_data = 0x89;
          end

        0x8a:
          begin
            tmp_key_data = 0x8a;
          end

        0x8b:
          begin
            tmp_key_data = 0x8b;
          end

        0x8c:
          begin
            tmp_key_data = 0x8c;
          end

        0x8d:
          begin
            tmp_key_data = 0x8d;
          end

        0x8e:
          begin
            tmp_key_data = 0x8e;
          end

        0x8f:
          begin
            tmp_key_data = 0x8f;
          end

        0x90:
          begin
            tmp_key_data = 0x90;
          end

        0x91:
          begin
            tmp_key_data = 0x91;
          end

        0x92:
          begin
            tmp_key_data = 0x92;
          end

        0x93:
          begin
            tmp_key_data = 0x93;
          end

        0x94:
          begin
            tmp_key_data = 0x94;
          end

        0x95:
          begin
            tmp_key_data = 0x95;
          end

        0x96:
          begin
            tmp_key_data = 0x96;
          end

        0x97:
          begin
            tmp_key_data = 0x97;
          end

        0x98:
          begin
            tmp_key_data = 0x98;
          end

        0x99:
          begin
            tmp_key_data = 0x99;
          end

        0x9a:
          begin
            tmp_key_data = 0x9a;
          end

        0x9b:
          begin
            tmp_key_data = 0x9b;
          end

        0x9c:
          begin
            tmp_key_data = 0x9c;
          end

        0x9d:
          begin
            tmp_key_data = 0x9d;
          end

        0x9e:
          begin
            tmp_key_data = 0x9e;
          end

        0x9f:
          begin
            tmp_key_data = 0x9f;
          end

        0xa0:
          begin
            tmp_key_data = 0xa0;
          end

        0xa1:
          begin
            tmp_key_data = 0xa1;
          end

        0xa2:
          begin
            tmp_key_data = 0xa2;
          end

        0xa3:
          begin
            tmp_key_data = 0xa3;
          end

        0xa4:
          begin
            tmp_key_data = 0xa4;
          end

        0xa5:
          begin
            tmp_key_data = 0xa5;
          end

        0xa6:
          begin
            tmp_key_data = 0xa6;
          end

        0xa7:
          begin
            tmp_key_data = 0xa7;
          end

        0xa8:
          begin
            tmp_key_data = 0xa8;
          end

        0xa9:
          begin
            tmp_key_data = 0xa9;
          end

        0xaa:
          begin
            tmp_key_data = 0xaa;
          end

        0xab:
          begin
            tmp_key_data = 0xab;
          end

        0xac:
          begin
            tmp_key_data = 0xac;
          end

        0xad:
          begin
            tmp_key_data = 0xad;
          end

        0xae:
          begin
            tmp_key_data = 0xae;
          end

        0xaf:
          begin
            tmp_key_data = 0xaf;
          end

        0xb0:
          begin
            tmp_key_data = 0xb0;
          end

        0xb1:
          begin
            tmp_key_data = 0xb1;
          end

        0xb2:
          begin
            tmp_key_data = 0xb2;
          end

        0xb3:
          begin
            tmp_key_data = 0xb3;
          end

        0xb4:
          begin
            tmp_key_data = 0xb4;
          end

        0xb5:
          begin
            tmp_key_data = 0xb5;
          end

        0xb6:
          begin
            tmp_key_data = 0xb6;
          end

        0xb7:
          begin
            tmp_key_data = 0xb7;
          end

        0xb8:
          begin
            tmp_key_data = 0xb8;
          end

        0xb9:
          begin
            tmp_key_data = 0xb9;
          end

        0xba:
          begin
            tmp_key_data = 0xba;
          end

        0xbb:
          begin
            tmp_key_data = 0xbb;
          end

        0xbc:
          begin
            tmp_key_data = 0xbc;
          end

        0xbd:
          begin
            tmp_key_data = 0xbd;
          end

        0xbe:
          begin
            tmp_key_data = 0xbe;
          end

        0xbf:
          begin
            tmp_key_data = 0xbf;
          end

        0xc0:
          begin
            tmp_key_data = 0xc0;
          end

        0xc1:
          begin
            tmp_key_data = 0xc1;
          end

        0xc2:
          begin
            tmp_key_data = 0xc2;
          end

        0xc3:
          begin
            tmp_key_data = 0xc3;
          end

        0xc4:
          begin
            tmp_key_data = 0xc4;
          end

        0xc5:
          begin
            tmp_key_data = 0xc5;
          end

        0xc6:
          begin
            tmp_key_data = 0xc6;
          end

        0xc7:
          begin
            tmp_key_data = 0xc7;
          end

        0xc8:
          begin
            tmp_key_data = 0xc8;
          end

        0xc9:
          begin
            tmp_key_data = 0xc9;
          end

        0xca:
          begin
            tmp_key_data = 0xca;
          end

        0xcb:
          begin
            tmp_key_data = 0xcb;
          end

        0xcc:
          begin
            tmp_key_data = 0xcc;
          end

        0xcd:
          begin
            tmp_key_data = 0xcd;
          end

        0xce:
          begin
            tmp_key_data = 0xce;
          end

        0xcf:
          begin
            tmp_key_data = 0xcf;
          end

        0xd0:
          begin
            tmp_key_data = 0xd0;
          end

        0xd1:
          begin
            tmp_key_data = 0xd1;
          end

        0xd2:
          begin
            tmp_key_data = 0xd2;
          end

        0xd3:
          begin
            tmp_key_data = 0xd3;
          end

        0xd4:
          begin
            tmp_key_data = 0xd4;
          end

        0xd5:
          begin
            tmp_key_data = 0xd5;
          end

        0xd6:
          begin
            tmp_key_data = 0xd6;
          end

        0xd7:
          begin
            tmp_key_data = 0xd7;
          end

        0xd8:
          begin
            tmp_key_data = 0xd8;
          end

        0xd9:
          begin
            tmp_key_data = 0xd9;
          end

        0xda:
          begin
            tmp_key_data = 0xda;
          end

        0xdb:
          begin
            tmp_key_data = 0xdb;
          end

        0xdc:
          begin
            tmp_key_data = 0xdc;
          end

        0xdd:
          begin
            tmp_key_data = 0xdd;
          end

        0xde:
          begin
            tmp_key_data = 0xde;
          end

        0xdf:
          begin
            tmp_key_data = 0xdf;
          end

        0xe0:
          begin
            tmp_key_data = 0xe0;
          end

        0xe1:
          begin
            tmp_key_data = 0xe1;
          end

        0xe2:
          begin
            tmp_key_data = 0xe2;
          end

        0xe3:
          begin
            tmp_key_data = 0xe3;
          end

        0xe4:
          begin
            tmp_key_data = 0xe4;
          end

        0xe5:
          begin
            tmp_key_data = 0xe5;
          end

        0xe6:
          begin
            tmp_key_data = 0xe6;
          end

        0xe7:
          begin
            tmp_key_data = 0xe7;
          end

        0xe8:
          begin
            tmp_key_data = 0xe8;
          end

        0xe9:
          begin
            tmp_key_data = 0xe9;
          end

        0xea:
          begin
            tmp_key_data = 0xea;
          end

        0xeb:
          begin
            tmp_key_data = 0xeb;
          end

        0xec:
          begin
            tmp_key_data = 0xec;
          end

        0xed:
          begin
            tmp_key_data = 0xed;
          end

        0xee:
          begin
            tmp_key_data = 0xee;
          end

        0xef:
          begin
            tmp_key_data = 0xef;
          end

        0xf0:
          begin
            tmp_key_data = 0xf0;
          end

        0xf1:
          begin
            tmp_key_data = 0xf1;
          end

        0xf2:
          begin
            tmp_key_data = 0xf2;
          end

        0xf3:
          begin
            tmp_key_data = 0xf3;
          end

        0xf4:
          begin
            tmp_key_data = 0xf4;
          end

        0xf5:
          begin
            tmp_key_data = 0xf5;
          end

        0xf6:
          begin
            tmp_key_data = 0xf6;
          end

        0xf7:
          begin
            tmp_key_data = 0xf7;
          end

        0xf8:
          begin
            tmp_key_data = 0xf8;
          end

        0xf9:
          begin
            tmp_key_data = 0xf9;
          end

        0xfa:
          begin
            tmp_key_data = 0xfa;
          end

        0xfb:
          begin
            tmp_key_data = 0xfb;
          end

        0xfc:
          begin
            tmp_key_data = 0xfc;
          end

        0xfd:
          begin
            tmp_key_data = 0xfd;
          end

        0xfe:
          begin
            tmp_key_data = 0xfe;
          end

        0xff:
          begin
            tmp_key_data = 0xff;
          end
      endcase // case (addr)
    end // read_key_data

endmodule // rc4_key_mem

//======================================================================
// EOF rc4_key_mem.v
//======================================================================
