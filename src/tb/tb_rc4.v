//======================================================================
//
// Tb_rc4.v
// ----------------
// Testbench for the RC4 stream cipher.
//
//
// Copyright (c) 2014, Secworks Sweden AB
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

//------------------------------------------------------------------
// Simulator directives.
//------------------------------------------------------------------
`timescale 1ns/10ps

module tb_rc4();
  
  //----------------------------------------------------------------
  // Internal constant and parameter definitions.
  //----------------------------------------------------------------
  parameter DEBUG = 1;

  parameter CLK_HALF_PERIOD = 2;
  
  
  //----------------------------------------------------------------
  // Register and Wire declarations.
  //----------------------------------------------------------------
  reg [31 : 0] cycle_ctr;
  reg [31 : 0] error_ctr;
  reg [31 : 0] tc_ctr;

  reg          tb_clk;
  reg          tb_reset_n;
  reg          tb_init;
  reg          tb_next;
  reg          tb_rfc4345_mode;
  reg [4 : 0]  tb_key_addr;
  reg [7 : 0]  tb_key_data;
  reg          tb_key_write;
  reg          tb_key_size;
  wire [7 : 0] tb_keystream_data;
  wire         tb_keystream_valid;
  
  
  //----------------------------------------------------------------
  // Device Under Test.
  //----------------------------------------------------------------
  rc4 dut(
          .clk(tb_clk),
          .reset_n(tb_reset_n),
          
          .init(tb_init),
          .next(tb_next),
          .rfc4345_mode(tb_rfc4345_mode),
          
          .key_addr(tb_key_addr),
          .key_data(tb_key_data),
          .key_write(tb_key_write),
          .key_size(tb_key_size),
           
          .keystream_data(tb_keystream_data),
          .keystream_valid(tb_keystream_valid)
         );
  

  //----------------------------------------------------------------
  // clk_gen
  //
  // Clock generator process. 
  //----------------------------------------------------------------
  always 
    begin : clk_gen
      #CLK_HALF_PERIOD tb_clk = !tb_clk;
    end // clk_gen
    

  //----------------------------------------------------------------
  // sys_monitor
  //----------------------------------------------------------------
  always
    begin : sys_monitor
      #(2 * CLK_HALF_PERIOD);
      cycle_ctr = cycle_ctr + 1;
    end

  
  //----------------------------------------------------------------
  // dump_dut_state()
  //
  // Dump the state of the dump when needed.
  //----------------------------------------------------------------
  task dump_dut_state();
    begin
      $display("State of DUT");
      $display("------------");
      $display("ip = 0x%02x, id = 0x%02x", dut.ip_reg, dut.idata);
      $display("jp = 0x%02x, jd = 0x%02x", dut.jp_reg, dut.jdata);
      $display("kp = 0x%02x, kd = 0x%02x", dut.kp_new, dut.kdata);
      $display("");
      
      $display("rc4_ctr  = 0x%03x", dut.rc4_ctr_reg);
      $display("rc4_ctrl = 0x%02x", dut.rc4_ctrl_reg);
      $display("");
    end
  endtask // dump_dut_state
  
  
  //----------------------------------------------------------------
  // reset_dut()
  //----------------------------------------------------------------
  task reset_dut();
    begin
      $display("*** Toggle reset.");
      tb_reset_n = 0;
      #(4 * CLK_HALF_PERIOD);
      tb_reset_n = 1;
    end
  endtask // reset_dut

  
  //----------------------------------------------------------------
  // init_sim()
  //
  // Initialize all counters and testbed functionality as well
  // as setting the DUT inputs to defined values.
  //----------------------------------------------------------------
  task init_sim();
    begin
      cycle_ctr = 32'h00000000;
      error_ctr = 32'h00000000;
      tc_ctr    = 32'h00000000;
      
      tb_clk     = 0;
      tb_reset_n = 0;

      tb_init         = 0;
      tb_next         = 0;
      tb_rfc4345_mode = 0;
      tb_key_addr     = 0;
      tb_key_data     = 0;
      tb_key_write    = 0;
      tb_key_size     = 0;
    end
  endtask // init_dut

  
  //----------------------------------------------------------------
  // display_test_result()
  //
  // Display the accumulated test results.
  //----------------------------------------------------------------
  task display_test_result();
    begin
      if (error_ctr == 0)
        begin
          $display("*** All %02d test cases completed successfully", tc_ctr);
        end
      else
        begin
          $display("*** %02d test cases did not complete successfully.", error_ctr);
        end
    end
  endtask // display_test_result
  

  //----------------------------------------------------------------
  // wait_ready()
  //
  // Wait for the ready flag in the dut to be set.
  //
  // Note: It is the callers responsibility to call the function
  // when the dut is actively processing and will in fact at some
  // point set the flag.
  //----------------------------------------------------------------
  task wait_ready();
    begin
      // while (!tb_ready)
      //   begin
      //     #(2 * CLK_HALF_PERIOD);
      //   end
    end
  endtask // wait_ready
                         
    
  //----------------------------------------------------------------
  // rc4_test
  //
  // The main test functionality. 
  //----------------------------------------------------------------
  initial
    begin : rc4_test
      $display("   -- Testbench for rc4 started --");

      init_sim();

      dump_dut_state();
      reset_dut();

      dump_dut_state();
      reset_dut();

      tb_init = 1;
      #(2 * CLK_HALF_PERIOD);
      tb_init = 0;
      #(10 * CLK_HALF_PERIOD);
      dump_dut_state();
      
      
      display_test_result();
      $display("*** Simulation done. ***");
      $finish;
    end // rc4_test
endmodule // tb_rc4

//======================================================================
// EOF tb_rc4.v
//======================================================================
