// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMT_ST_WATCHDOG_TIMEOUT_TEST_SV__
`define __UVMT_ST_WATCHDOG_TIMEOUT_TEST_SV__


/**
 * 
 */
class watchdog_error_demoter_c extends uvm_report_catcher;
   
   bit  witnessed_timeout_error = 0;
   bit  witnessed_final_fatal   = 0;
   
   
   `uvm_object_utils(watchdog_error_demoter_c)
   
   
   /**
    * Default constructor
    */
   function new(string name="watchdog_error_demoter");
     super.new(name);
   endfunction : new
   
   /**
    * This example demotes "MY_ID" errors to an info message
    */
   function action_e catch();
      if ((get_severity() == UVM_ERROR) && (get_id() == "WATCHDOG")) begin
         set_severity(UVM_INFO);
         witnessed_timeout_error = 1;
      end
      if ((get_severity() == UVM_FATAL) && (get_id() == "WATCHDOG")) begin
         set_severity(UVM_INFO);
         witnessed_final_fatal = 1;
         uvm_config_db#(bit)::set(null, "", "sim_finished", 1);
         $finish();
      end
      return THROW;
   endfunction : catch
   
endclass : watchdog_error_demoter_c


/**
 * TODO Describe uvmt_st_watchdog_timeout_test_c
 */
class uvmt_st_watchdog_timeout_test_c extends uvmt_st_base_test_c;
   
   watchdog_error_demoter_c  demoter; ///< 
   
   
   `uvm_component_utils(uvmt_st_watchdog_timeout_test_c)
   
   
   /**
    * * Disables heartbeat monitor.
    * * Sets watchdog time to less than the simulation timeout
    */
   extern function new(string name="uvmt_st_watchdog_timeout_test", uvm_component parent=null);
   
   /**
    * TODO Describe uvmt_st_watchdog_timeout_test_c::end_of_elaboration_phase()
    */
   extern virtual function void end_of_elaboration_phase(uvm_phase phase);
   
   /**
    * Holds onto objection indefinitely.
    */
   extern virtual task main_phase(uvm_phase phase);
   
   /**
    * Checks that the watchdog correctly detected the timeout.
    */
   extern virtual function void check_phase(uvm_phase phase);
   
endclass : uvmt_st_watchdog_timeout_test_c


function uvmt_st_watchdog_timeout_test_c::new(string name="uvmt_st_watchdog_timeout_test", uvm_component parent=null);
   
   super.new(name, parent);
   `uvml_time_hrtbt_set_cfg(enabled, 0)
   
endfunction : new


function void uvmt_st_watchdog_timeout_test_c::end_of_elaboration_phase(uvm_phase phase);
   
   super.end_of_elaboration_phase(phase);
   `uvml_time_watchdog_set_cfg(watchdog_time, test_cfg.simulation_timeout-1)
   demoter = watchdog_error_demoter_c::type_id::create("demoter");
   uvm_report_cb::add(null, demoter);
   
endfunction : end_of_elaboration_phase


task uvmt_st_watchdog_timeout_test_c::main_phase(uvm_phase phase);
   
   super.main_phase(phase);
   phase.raise_objection(this);
   
endtask : main_phase



function void uvmt_st_watchdog_timeout_test_c::check_phase(uvm_phase phase);
   
   super.check_phase(phase);
   
   if (!uvml_time_default_watchdog.timeout_occurred) begin
      `uvm_error("TEST", "Watchdog timer did not record a timeout during simulation")
   end
   /*if (!demoter.witnessed_timeout_error) begin
      `uvm_error("TEST", "Watchdog timer did not issue an error during simulation")
   end*/
   if (!demoter.witnessed_final_fatal) begin
      `uvm_error("TEST", "Watchdog timer did not issue a fatal during simulation")
   end
   
endfunction : check_phase


`endif // __UVMT_ST_WATCHDOG_TIMEOUT_TEST_SV__
