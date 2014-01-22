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
                   
                   input wire  [5 : 0] key_write_addr,
                   input wire  [7 : 0] key_write_data,
                   input wire          key_write,
                   input wire          key_size,
                     
                   input wire  [5 : 0] key_read_addr,
                   output wire [7 : 0] key_read_data
                  );

  
  //----------------------------------------------------------------
  // Registers including update variables and write enable.
  //----------------------------------------------------------------
  reg [255 : 0] key_reg;
  reg [255 : 0] key_new;
  reg           key_we;

  reg [7 : 0] key00_reg;
  reg [7 : 0] key00_new;
  reg         key00_we;
  reg [7 : 0] key01_reg;
  reg [7 : 0] key01_new;
  reg         key01_we;
  reg [7 : 0] key02_reg;
  reg [7 : 0] key02_new;
  reg         key02_we;
  reg [7 : 0] key03_reg;
  reg [7 : 0] key03_new;
  reg         key03_we;
  reg [7 : 0] key04_reg;
  reg [7 : 0] key04_new;
  reg         key04_we;
  reg [7 : 0] key05_reg;
  reg [7 : 0] key05_new;
  reg         key05_we;
  reg [7 : 0] key06_reg;
  reg [7 : 0] key06_new;
  reg         key06_we;
  reg [7 : 0] key07_reg;
  reg [7 : 0] key07_new;
  reg         key07_we;
  reg [7 : 0] key08_reg;
  reg [7 : 0] key08_new;
  reg         key08_we;
  reg [7 : 0] key09_reg;
  reg [7 : 0] key09_new;
  reg         key09_we;
  reg [7 : 0] key0a_reg;
  reg [7 : 0] key0a_new;
  reg         key0a_we;
  reg [7 : 0] key0b_reg;
  reg [7 : 0] key0b_new;
  reg         key0b_we;
  reg [7 : 0] key0c_reg;
  reg [7 : 0] key0c_new;
  reg         key0c_we;
  reg [7 : 0] key0d_reg;
  reg [7 : 0] key0d_new;
  reg         key0d_we;
  reg [7 : 0] key0e_reg;
  reg [7 : 0] key0e_new;
  reg         key0e_we;
  reg [7 : 0] key0f_reg;
  reg [7 : 0] key0f_new;
  reg         key0f_we;

  reg [7 : 0] key10_reg;
  reg [7 : 0] key10_new;
  reg         key10_we;
  reg [7 : 0] key11_reg;
  reg [7 : 0] key11_new;
  reg         key11_we;
  reg [7 : 0] key12_reg;
  reg [7 : 0] key12_new;
  reg         key12_we;
  reg [7 : 0] key13_reg;
  reg [7 : 0] key13_new;
  reg         key13_we;
  reg [7 : 0] key14_reg;
  reg [7 : 0] key14_new;
  reg         key14_we;
  reg [7 : 0] key15_reg;
  reg [7 : 0] key15_new;
  reg         key15_we;
  reg [7 : 0] key16_reg;
  reg [7 : 0] key16_new;
  reg         key16_we;
  reg [7 : 0] key17_reg;
  reg [7 : 0] key17_new;
  reg         key17_we;
  reg [7 : 0] key18_reg;
  reg [7 : 0] key18_new;
  reg         key18_we;
  reg [7 : 0] key19_reg;
  reg [7 : 0] key19_new;
  reg         key19_we;
  reg [7 : 0] key1a_reg;
  reg [7 : 0] key1a_new;
  reg         key1a_we;
  reg [7 : 0] key1b_reg;
  reg [7 : 0] key1b_new;
  reg         key1b_we;
  reg [7 : 0] key1c_reg;
  reg [7 : 0] key1c_new;
  reg         key1c_we;
  reg [7 : 0] key1d_reg;
  reg [7 : 0] key1d_new;
  reg         key1d_we;
  reg [7 : 0] key1e_reg;
  reg [7 : 0] key1e_new;
  reg         key1e_we;
  reg [7 : 0] key1f_reg;
  reg [7 : 0] key1f_new;
  reg         key1f_we;
  
  reg           size;

  
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
  // All registers are positive edge triggered with synchronous
  // active low reset. All registers have write enable.
  //----------------------------------------------------------------
  always @ (posedge clk)
    begin : reg_update
      if (!reset_n)
        begin
          key00_reg <= 8'h00;
          key01_reg <= 8'h00;
          key02_reg <= 8'h00;
          key03_reg <= 8'h00;
          key04_reg <= 8'h00;
          key05_reg <= 8'h00;
          key06_reg <= 8'h00;
          key07_reg <= 8'h00;
          key08_reg <= 8'h00;
          key09_reg <= 8'h00;
          key0a_reg <= 8'h00;
          key0b_reg <= 8'h00;
          key0c_reg <= 8'h00;
          key0d_reg <= 8'h00;
          key0e_reg <= 8'h00;
          key0f_reg <= 8'h00;
          key10_reg <= 8'h00;
          key11_reg <= 8'h00;
          key12_reg <= 8'h00;
          key13_reg <= 8'h00;
          key14_reg <= 8'h00;
          key15_reg <= 8'h00;
          key16_reg <= 8'h00;
          key17_reg <= 8'h00;
          key18_reg <= 8'h00;
          key19_reg <= 8'h00;
          key1a_reg <= 8'h00;
          key1b_reg <= 8'h00;
          key1c_reg <= 8'h00;
          key1d_reg <= 8'h00;
          key1e_reg <= 8'h00;
          key1f_reg <= 8'h00;
          
          size      <= 0;
        end
      else
        begin
          if (key00_we)
            begin
              key00_reg <= key_write_data;
            end
          if (key01_we)
            begin
              key01_reg <= key_write_data;
            end
          if (key02_we)
            begin
              key02_reg <= key_write_data;
            end
          if (key03_we)
            begin
              key03_reg <= key_write_data;
            end
          if (key04_we)
            begin
              key04_reg <= key_write_data;
            end
          if (key05_we)
            begin
              key05_reg <= key_write_data;
            end
          if (key06_we)
            begin
              key06_reg <= key_write_data;
            end
          if (key07_we)
            begin
              key07_reg <= key_write_data;
            end
          if (key08_we)
            begin
              key08_reg <= key_write_data;
            end
          if (key09_we)
            begin
              key09_reg <= key_write_data;
            end
          if (key0a_we)
            begin
              key0a_reg <= key_write_data;
            end
          if (key0b_we)
            begin
              key0b_reg <= key_write_data;
            end
          if (key0c_we)
            begin
              key0c_reg <= key_write_data;
            end
          if (key0d_we)
            begin
              key0d_reg <= key_write_data;
            end
          if (key0e_we)
            begin
              key0e_reg <= key_write_data;
            end
          if (key0f_we)
            begin
              key0f_reg <= key_write_data;
            end

          if (key10_we)
            begin
              key10_reg <= key_write_data;
            end
          if (key11_we)
            begin
              key11_reg <= key_write_data;
            end
          if (key12_we)
            begin
              key12_reg <= key_write_data;
            end
          if (key13_we)
            begin
              key13_reg <= key_write_data;
            end
          if (key14_we)
            begin
              key14_reg <= key_write_data;
            end
          if (key15_we)
            begin
              key15_reg <= key_write_data;
            end
          if (key16_we)
            begin
              key16_reg <= key_write_data;
            end
          if (key17_we)
            begin
              key17_reg <= key_write_data;
            end
          if (key18_we)
            begin
              key18_reg <= key_write_data;
            end
          if (key19_we)
            begin
              key19_reg <= key_write_data;
            end
          if (key1a_we)
            begin
              key1a_reg <= key_write_data;
            end
          if (key1b_we)
            begin
              key1b_reg <= key_write_data;
            end
          if (key1c_we)
            begin
              key1c_reg <= key_write_data;
            end
          if (key1d_we)
            begin
              key1d_reg <= key_write_data;
            end
          if (key1e_we)
            begin
              key1e_reg <= key_write_data;
            end
          if (key1f_we)
            begin
              key1f_reg <= key_write_data;
            end
          
          if (init)
            begin
              size <= key_size;
            end
        end
    end // reg_update


  //----------------------------------------------------------------
  // write_key_data
  //
  // Write the given byte into the correct key data register.
  //----------------------------------------------------------------
  always @*
    begin : write_key_data
      key00_we  = 0;
      key01_we  = 0;
      key02_we  = 0;
      key03_we  = 0;
      key04_we  = 0;
      key05_we  = 0;
      key06_we  = 0;
      key07_we  = 0;
      key08_we  = 0;
      key09_we  = 0;
      key0a_we  = 0;
      key0b_we  = 0;
      key0c_we  = 0;
      key0d_we  = 0;
      key0e_we  = 0;
      key0f_we  = 0;
      key10_we  = 0;
      key11_we  = 0;
      key12_we  = 0;
      key13_we  = 0;
      key14_we  = 0;
      key15_we  = 0;
      key16_we  = 0;
      key17_we  = 0;
      key18_we  = 0;
      key19_we  = 0;
      key1a_we  = 0;
      key1b_we  = 0;
      key1c_we  = 0;
      key1d_we  = 0;
      key1e_we  = 0;
      key1f_we  = 0;

      if (key_write)
        begin
          case (key_write_addr)
            6'h00:
              begin
                key00_we  = 1;
              end
            6'h01:
              begin
                key01_we  = 1;
              end
            6'h02:
              begin
                key02_we  = 1;
              end
            6'h03:
              begin
                key03_we  = 1;
              end
            6'h04:
              begin
                key04_we  = 1;
              end
            6'h05:
              begin
                key05_we  = 1;
              end
            6'h06:
              begin
                key06_we  = 1;
              end
            6'h07:
              begin
                key07_we  = 1;
              end
            6'h08:
              begin
                key08_we  = 1;
              end
            6'h09:
              begin
                key09_we  = 1;
              end
            6'h0a:
              begin
                key0a_we  = 1;
              end
            6'h0b:
              begin
                key0b_we  = 1;
              end
            6'h0c:
              begin
                key0c_we  = 1;
              end
            6'h0d:
              begin
                key0d_we  = 1;
              end
            6'h0e:
              begin
                key0e_we  = 1;
              end
            6'h0f:
              begin
                key0f_we  = 1;
              end
            6'h10:
              begin
                key10_we  = 1;
              end
            6'h11:
              begin
                key11_we  = 1;
              end
            6'h12:
              begin
                key12_we  = 1;
              end
            6'h13:
              begin
                key13_we  = 1;
              end
            6'h14:
              begin
                key14_we  = 1;
              end
            6'h15:
              begin
                key15_we  = 1;
              end
            6'h16:
              begin
                key16_we  = 1;
              end
            6'h17:
              begin
                key17_we  = 1;
              end
            6'h18:
              begin
                key18_we  = 1;
              end
            6'h19:
              begin
                key19_we  = 1;
              end
            6'h1a:
              begin
                key1a_we  = 1;
              end
            6'h1b:
              begin
                key1b_we  = 1;
              end
            6'h1c:
              begin
                key1c_we  = 1;
              end
            6'h1d:
              begin
                key1d_we  = 1;
              end
            6'h1e:
              begin
                key1e_we  = 1;
              end
            6'h1f:
              begin
                key1f_we  = 1;
              end
            
            default:
              begin

              end
          endcase // case (key_write_addr)
        end
    end

  
  //----------------------------------------------------------------
  // read_key_data
  //
  // Address mux. The address used is modified based on
  // the given key size before selecting the bits in the key
  // register.
  //----------------------------------------------------------------
  always @*
    begin : read_key_data
      reg [5 : 0] addr;
      
      if (size)
        begin
          addr = key_write_addr;
        end
      else
        begin
          addr = {1'b0, key_write_addr[4 : 0]};
        end

      case (addr)
        6'h00:
          begin
            tmp_key_read_data = key00_reg;
          end

        6'h01:
          begin
            tmp_key_read_data = key01_reg;
          end

        6'h02:
          begin
            tmp_key_read_data = key02_reg;
          end

        6'h03:
          begin
            tmp_key_read_data = key03_reg;
          end

        6'h04:
          begin
            tmp_key_read_data = key04_reg;
          end

        6'h05:
          begin
            tmp_key_read_data = key05_reg;
          end

        6'h06:
          begin
            tmp_key_read_data = key06_reg;
          end

        6'h07:
          begin
            tmp_key_read_data = key07_reg;
          end

        6'h08:
          begin
            tmp_key_read_data = key08_reg;
          end

        6'h09:
          begin
            tmp_key_read_data = key09_reg;
          end

        6'h0a:
          begin
            tmp_key_read_data = key0a_reg;
          end

        6'h0b:
          begin
            tmp_key_read_data = key0b_reg;
          end

        6'h0c:
          begin
            tmp_key_read_data = key0c_reg;
          end

        6'h0d:
          begin
            tmp_key_read_data = key0d_reg;
          end

        6'h0e:
          begin
            tmp_key_read_data = key0e_reg;
          end

        6'h0f:
          begin
            tmp_key_read_data = key0f_reg;
          end
        
        6'h10:
          begin
            tmp_key_read_data = key10_reg;
          end

        6'h11:
          begin
            tmp_key_read_data = key11_reg;
          end

        6'h12:
          begin
            tmp_key_read_data = key12_reg;
          end

        6'h13:
          begin
            tmp_key_read_data = key13_reg;
          end

        6'h14:
          begin
            tmp_key_read_data = key14_reg;
          end

        6'h15:
          begin
            tmp_key_read_data = key15_reg;
          end

        6'h16:
          begin
            tmp_key_read_data = key16_reg;
          end

        6'h17:
          begin
            tmp_key_read_data = key17_reg;
          end

        6'h18:
          begin
            tmp_key_read_data = key18_reg;
          end

        6'h19:
          begin
            tmp_key_read_data = key19_reg;
          end

        6'h1a:
          begin
            tmp_key_read_data = key1a_reg;
          end

        6'h1b:
          begin
            tmp_key_read_data = key1b_reg;
          end

        6'h1c:
          begin
            tmp_key_read_data = key1c_reg;
          end

        6'h1d:
          begin
            tmp_key_read_data = key1d_reg;
          end

        6'h1e:
          begin
            tmp_key_read_data = key1e_reg;
          end

        6'h1f:
          begin
            tmp_key_read_data = key1f_reg;
          end

        default:
          begin
            tmp_key_read_data = 0;
          end
        
      endcase // case (addr)
    end // read_key_data

endmodule // rc4_key_mem

//======================================================================
// EOF rc4_key_mem.v
//======================================================================
