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
  parameter CLK_PERIOD = 2 * CLK_HALF_PERIOD;


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
      $display("--------------------------------------");
      $display("State of DUT at cycle %08d", cycle_ctr);
      $display("inputs and outputs:");
      $display("init: 0x%1x, next: 0x%1x", dut.init, dut.next);
      $display("keylen: 0x%1x, key: 0x%064x", dut.keylen, dut.key);
      $display("ready: 0x%1x, keystream: 0x%02x", dut.ready, dut.keystream);
      $display("");

      $display("State:");
      $display("init_state: 0x%1x, update_state: 0x%1x, ksa_mode: 0x%1x",
               dut.init_state, dut.update_state, dut.ksa_mode);
      $display("state_iwe: 0x%1x, state_iaddr: 0x%02x, state_inew: 0x%02x",
               dut.state_iwe, dut.state_iaddr, dut.state_inew);
      $display("state_jwe: 0x%1x, state_jaddr: 0x%02x, state_jnew: 0x%02x",
               dut.state_jwe, dut.state_jaddr, dut.state_jnew);
      $display("");

      $display("Control:");
      $display("ip_reg: 0x%02x, ip_new: 0x%02x, ip_we: 0x%1x, ip_rst: 0x%1x, ip_nxt: 0x%1x",
               dut.ip_reg, dut.ip_new, dut.ip_we, dut.ip_rst, dut.ip_nxt);
      $display("jp_reg: 0x%02x, jp_new: 0x%02x, jp_we: 0x%1x, jp_rst: 0x%1x, jp_nxt: 0x%1x",
               dut.jp_reg, dut.jp_new, dut.jp_we, dut.jp_rst, dut.jp_nxt);
      $display("rc4_core_ctrl_reg: 0x%02x", dut.rc4_core_ctrl_reg);
      $display("");
    end
  endtask // dump_dut_state


  //----------------------------------------------------------------
  // dump_state_mem()
  //
  // Dump the state array.
  //----------------------------------------------------------------
  task dump_state_mem;
    integer i;
    begin
      $display("State");
      $display("-----");

      for (i = 0 ; i < 32 ; i = i + 1)
        begin
          $display("state[0x%02x]: 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x",
                   i, dut.state[i * 8 + 0], dut.state[i * 8 + 1],
                   dut.state[i * 8 + 2], dut.state[i * 8 + 3],
                   dut.state[i * 8 + 4], dut.state[i * 8 + 5],
                   dut.state[i * 8 + 6], dut.state[i * 8 + 7]);
        end
      $display("");
    end
  endtask // dump_state_mem


  //----------------------------------------------------------------
  // reset_dut()
  //----------------------------------------------------------------
  task reset_dut;
    begin
      $display("*** Toggle reset.");
      tb_reset_n = 0;
      #(2 * CLK_PERIOD);
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
      tb_key     = 256'h0;
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
  // Test that the state is initialized correctly.
  //----------------------------------------------------------------
  task test_init;
    begin
      tc_ctr = tc_ctr + 1;

//      tb_key     = 256'h1f1e1d1c1a19181716151413121110_0f0e0d0c0b0a09080706050403020100;
      tb_key = {32{8'h02}};
      tb_keylen  = 1'h1;

      $display("Starting init");
      tb_init = 1'h1;
      #(2 * CLK_PERIOD);

      tb_init = 1'h0;
      #(10 * CLK_PERIOD);

      while (!tb_ready) begin
      #(CLK_PERIOD);
      end
      #(CLK_PERIOD);

      $display("Init should be done. Dumping state.");

      dump_state_mem();
    end
  endtask // test_init


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
      dump_state_mem();

      test_init();

      display_test_result();
      $display("   *** Testbench for rc4_core completed ***");
      $finish;
    end // rc4_core_test
endmodule // tb_rc4_core

//======================================================================
// EOF tb_rc4_core.v
//======================================================================
