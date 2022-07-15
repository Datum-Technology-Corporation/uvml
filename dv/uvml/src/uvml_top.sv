// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVML_TOP_SV__
`define __UVML_TOP_SV__


/**
 * Module launching simulation and printing summary at the end of simulation.
 */
module uvml_top;

   import uvm_pkg ::*;
   import uvml_pkg::*;

   /**
    * UVML-based test bench entry point.
    */
   task run_test();
      // Specify time format for simulation
      $timeformat(
         .units_number       (   -9),
         .precision_number   (    3),
         .suffix_string      (" ns"),
         .minimum_field_width(   18)
      );

      // Top-level UVM options
      uvm_top.enable_print_topology = 0;
      uvm_top.finish_on_completion  = 1;

      // Launch the test specified by CLI
      uvm_top.run_test();
   endtask : run_test

   /**
    * End-of-test summary printout.
    */
   final begin
      uvm_report_server  rs           = uvm_top.get_report_server();
      int                error_count  = rs.get_severity_count(UVM_ERROR);
      int                fatal_count  = rs.get_severity_count(UVM_FATAL);
      bit                sim_finished = 0;
      const string  cli_red   = "\033[31m\033[1m";
      const string  cli_green = "\033[32m\033[1m";
      const string  cli_reset = "\033[0m";
      string  banner_string ;
      string  summary_string;

      void'(uvm_config_db#(bit)::get(null, "", "sim_finished", sim_finished));

      if (sim_finished && (error_count == 0) && (fatal_count == 0)) begin
         banner_string = {"\n", cli_green, "\n", uvml_banner_large_passed, "\n", uvml_banner_small_passed, "\n", cli_reset};
      end
      else begin
         banner_string = {"\n", cli_red, "\n", uvml_banner_large_passed, "\n"};
         if (sim_finished == 0) begin
            banner_string = {banner_string, uvml_banner_small_failed, "\n", cli_reset};
         end
         else begin
            banner_string = {banner_string, uvml_banner_small_failed_aborted, "\n", cli_reset};
         end
      end
      $display(reset);

      `uvm_info("UVML_TOP", "\n*** Test Summary ***", UVM_NONE)
      `uvm_info("UVML_TOP", banner_string           , UVM_NONE)
      `uvm_info("UVML_TOP", summary_string          , UVM_NONE)
   end

endmodule : uvml_top


`endif // __UVML_TOP_SV__
