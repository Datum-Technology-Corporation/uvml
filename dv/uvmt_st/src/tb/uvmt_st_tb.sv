// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMT_ST_TB_SV__
`define __UVMT_ST_TB_SV__


/**
 * Module encapsulating the Moore.io UVM Extension Library VIP Self-Test DUT wrapper, agents and clock generating
 * interfaces.  The clock and reset interface only feeds into the Moore.io UVM Extension Library VIP interfaces.
 */
module uvmt_st_tb;

   import uvm_pkg::*;
   import uvmt_st_pkg::*;

   // Clocking & Reset
   uvmt_st_clknrst_gen_if  clknrst_gen_if();

   // Agent interfaces
   uvma_st_if  tx_if(.clk(clknrst_gen_if.clk), .reset_n(clknrst_gen_if.reset_n));
   uvma_st_if  rx_if(.clk(clknrst_gen_if.clk), .reset_n(clknrst_gen_if.reset_n));

   // DUT instance
   uvmt_st_dut_wrap  dut_wrap(.*);


   /**
    * Test bench entry point.
    */
   initial begin
      // Specify time format for simulation
      $timeformat(
         .units_number       (   -9),
         .precision_number   (    3),
         .suffix_string      (" ns"),
         .minimum_field_width(   18)
      );

      // Add interfaces to uvm_config_db
      uvm_config_db#(virtual uvmt_st_clknrst_gen_if)::set(null, "*"             , "clknrst_gen_vif", clknrst_gen_if);
      uvm_config_db#(virtual uvma_st_if            )::set(null, "*.env.tx_agent", "vif"            , tx_if         );
      uvm_config_db#(virtual uvma_st_if            )::set(null, "*.env.rx_agent", "vif"            , rx_if         );

      // Run test
      uvm_top.enable_print_topology = 0;
      uvm_top.finish_on_completion  = 1;
      uvm_top.run_test();
   end

endmodule : uvmt_st_tb


`endif // __UVMT_ST_TB_SV__
