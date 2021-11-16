//======================================================================
//
// tb_rc4_core.v
// -------------
// Testbench for the rc4_core stream cipher module.
//
//
// Copyright (c) 2021, Assured AB
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

module tb_rc4_core();

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

  reg           tb_clk;
  reg           tb_reset_n;
  reg           tb_init;
  reg           tb_next;
  reg [255 : 0] tb_key;
  reg           tb_keylen;
  wire [7 : 0]  tb_keystream;
  wire          tb_ready;


  //----------------------------------------------------------------
  // Device Under Test.
  //----------------------------------------------------------------
  rc4_core dut(
               .clk(tb_clk),
               .reset_n(tb_reset_n),

               .init(tb_init),
               .next(tb_next),

               .key(tb_key),
               .keylen(tb_keylen),

               .keystream(tb_keystream),
               .ready(tb_ready)
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

      if (DEBUG)
        begin
          dump_dut_state();

        end
    end


  //----------------------------------------------------------------
  // dump_dut_state()
  //
  // Dump the state of the dump when needed.
  //----------------------------------------------------------------
  task dump_dut_state;
    begin
      $display("State of DUT at cycle %08d", cycle_ctr);
      $display("");
      $display("");
    end
  endtask // dump_dut_state


  //----------------------------------------------------------------
  // dump_state_mem()
  //
  // Dump the state mem.
  //----------------------------------------------------------------
//  task dump_state_mem;
//    reg [8 : 0] i;
//    begin
//      $display("State memory");
//      $display("------------");
//
//      for (i = 0 ; i < 256 ; i = i + 1)
//        begin
//          $display("state_mem[0x%02x] = 0x%02x", i[7 : 0],
//                   dut.smem.state_mem[i[7 : 0]]);
//        end
//      $display("");
//    end
//  endtask // dump_state_mem


  //----------------------------------------------------------------
  // reset_dut()
  //----------------------------------------------------------------
  task reset_dut;
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
  task init_sim;
    begin
      cycle_ctr = 32'h0;
      error_ctr = 32'h0;
      tc_ctr    = 32'h0;

      tb_clk     = 1'h0;
      tb_reset_n = 1'h0;
      tb_init    = 1'h0;
      tb_next    = 1'h0;
      tb_key     = 256'h1f1e1d1c1a19181716151413121110_0f0e0d0c0b0a09080706050403020100;
      tb_keylen  = 1'h0;
    end
  endtask // init_dut


  //----------------------------------------------------------------
  // display_test_result()
  //
  // Display the accumulated test results.
  //----------------------------------------------------------------
  task display_test_result;
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
  // rc4_core_test
  //
  // The main test functionality.
  //----------------------------------------------------------------
  initial
    begin : rc4_core_test
      $display("   *** Testbench for rc4_core started ***");

      init_sim();

      dump_dut_state();
      reset_dut();

      dump_dut_state();
      reset_dut();

      display_test_result();
      $display("   *** Testbench for rc4_core completed ***");
      $finish;
    end // rc4_core_test
endmodule // tb_rc4_core

//======================================================================
// EOF tb_rc4_core.v
//======================================================================
