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
   
   /**
    * End-of-test summary printout.
    */
   final begin
      string             summary_string;
      uvm_report_server  rs;
      int                err_count;
      int                fatal_count;
      static bit         sim_finished = 0;
      
      static string  red   = "\033[31m\033[1m";
      static string  green = "\033[32m\033[1m";
      static string  reset = "\033[0m";
      
      rs          = uvm_top.get_report_server();
      err_count   = rs.get_severity_count(UVM_ERROR);
      fatal_count = rs.get_severity_count(UVM_FATAL);
      
      void'(uvm_config_db#(bit)::get(null, "", "sim_finished", sim_finished));
      
      $display("\n*** Test Summary ***\n");
      
      if (sim_finished && (err_count == 0) && (fatal_count == 0)) begin
         $display("    PPPPPPP    AAAAAA    SSSSSS    SSSSSS   EEEEEEEE  DDDDDDD     ");
         $display("    PP    PP  AA    AA  SS    SS  SS    SS  EE        DD    DD    ");
         $display("    PP    PP  AA    AA  SS        SS        EE        DD    DD    ");
         $display("    PPPPPPP   AAAAAAAA   SSSSSS    SSSSSS   EEEEE     DD    DD    ");
         $display("    PP        AA    AA        SS        SS  EE        DD    DD    ");
         $display("    PP        AA    AA  SS    SS  SS    SS  EE        DD    DD    ");
         $display("    PP        AA    AA   SSSSSS    SSSSSS   EEEEEEEE  DDDDDDD     ");
         $display("    ----------------------------------------------------------");
         $display("                        SIMULATION PASSED                     ");
         $display("    ----------------------------------------------------------");
      end
      else begin
         $display("    FFFFFFFF   AAAAAA   IIIIII  LL        EEEEEEEE  DDDDDDD       ");
         $display("    FF        AA    AA    II    LL        EE        DD    DD      ");
         $display("    FF        AA    AA    II    LL        EE        DD    DD      ");
         $display("    FFFFF     AAAAAAAA    II    LL        EEEEE     DD    DD      ");
         $display("    FF        AA    AA    II    LL        EE        DD    DD      ");
         $display("    FF        AA    AA    II    LL        EE        DD    DD      ");
         $display("    FF        AA    AA  IIIIII  LLLLLLLL  EEEEEEEE  DDDDDDD       ");
         
         if (sim_finished == 0) begin
            $display("    --------------------------------------------------------");
            $display("                   SIMULATION FAILED - ABORTED              ");
            $display("    --------------------------------------------------------");
         end
         else begin
            $display("    --------------------------------------------------------");
            $display("                       SIMULATION FAILED                    ");
            $display("    --------------------------------------------------------");
         end
      end
   end
   
endmodule : uvmt_st_tb


`endif // __UVMT_ST_TB_SV__
