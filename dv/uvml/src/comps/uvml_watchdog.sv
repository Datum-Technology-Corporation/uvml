// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVML_WATCHDOG_SV__
`define __UVML_WATCHDOG_SV__


/**
 * Component enforcing a maximum simulation time.  Adapted from example in "Advanced UVM" by B.Hunter:
 * https://github.com/advanced-uvm/second_edition/blob/master/recipes/5.watchdog.sv
 */
class uvml_watchdog_c extends uvm_component;
   
   bit           enabled         ; ///< 0 disables the component
   int unsigned  timeout         ; ///< The time, in ns, at which the test will timeout
   bit           timeout_occurred; ///< Set to 1 on deadlock
   
   
   `uvm_component_utils_begin(uvml_watchdog_c)
      `uvm_field_int(enabled, UVM_DEFAULT          )
      `uvm_field_int(timeout, UVM_DEFAULT + UVM_DEC)
   `uvm_component_utils_end
   
   
   /**
    * Sets default field values.
    */
   extern function new(string name="uvml_watchdog", uvm_component parent=null);
   
   /**
    * Check for plusargs to override any modifications to the watchdog_time
    */
   extern virtual function void start_of_simulation_phase(uvm_phase phase);
   
   /**
    * If watchdog time ever passes, then it's time to bail out and jump to the check phase
    */
   extern virtual task run_phase(uvm_phase phase);
   
   /**
    * The last thing that will ever happen
    */
   extern virtual function void final_phase(uvm_phase phase);
   
   /**
    * Print out all of the objectors to the current phase
    */
   extern virtual function void objector_report();
   
endclass : uvml_watchdog_c


function uvml_watchdog_c::new(string name="uvml_watchdog", uvm_component parent=null);
   
   super.new(name, parent);
   enabled          = 1;
   timeout          = uvml_watchdog_default_timeout;
   timeout_occurred = 0;
   
endfunction : new


function void uvml_watchdog_c::start_of_simulation_phase(uvm_phase phase);
   
   int  plus_wdog_time;
   
   super.start_of_simulation_phase(phase);
   
   if ($value$plusargs({uvml_watchdog_cli_arg, "=%d"}, plus_wdog_time)) begin
      timeout = plus_wdog_time;
   end
   `uvm_info("WATCHDOG", $sformatf("Global Watchdog Timer set to %0dns.", uvml_watchdog_default_timeout), UVM_LOW)
   
endfunction : start_of_simulation_phase


task uvml_watchdog_c::run_phase(uvm_phase phase);
   
   uvm_phase   current_phase;
   uvm_domain  common_domain;
   
   if (enabled) begin
      if (timeout == 0) begin
         return;
      end
      #(timeout * 1ns);  // wait here...
      //`uvm_error("WATCHDOG", "Watchdog Timeout! Objection report:")
      //`uvm_fatal("WATCHDOG", $sformatf("Timeout of %0dns has elapsed.  Ending simulation..", timeout))
      `uvm_fatal("TIMEOUT", $sformatf("Ending simulation - watchdog timeout of %0dns has elapsed.  Heartbeat list:\n%s", timeout, uvml_default_hrtbt_mon.print_comp_names()))
      // TODO Fix this for vivado (can't jump phases): make all commented out code work and remove the uvm_fatal in here
      objector_report();
      timeout_occurred = 1;
      
      /*current_phase = get_current_phase();
      if (current_phase == null) begin
         `uvm_fatal("", "Exiting due to timeout, but could not identify phase responsible")
      end
      else begin*/
         //common_domain = uvm_domain::get_common_domain();
         //common_domain.jump(uvm_check_phase::get());
      /*end*/
   end
   
endtask : run_phase


function void uvml_watchdog_c::final_phase(uvm_phase phase);
   
   if (enabled) begin
      if (timeout_occurred) begin
         `uvm_fatal("WATCHDOG", "Exiting due to watchdog timeout.")
      end
   end
   
endfunction : final_phase


function void uvml_watchdog_c::objector_report();
   
   /*string str;
   uvm_object objectors[$];
   uvm_phase current_phase = get_current_phase();

   if (current_phase == null) begin
      `uvm_fatal("WATCHDOG", "Unable to determine the current phase.")
   end
   
   current_phase.get_objection().get_objectors(objectors);

   str = $sformatf("\n\nCurrently Executing Phase :  %s\n", current_phase.get_name());
   str = {str, "List of Objectors   \n"};
   str = {str, "Hierarchical Name                              Class Type\n"};
   foreach (objectors[obj]) begin
      str = {str, $sformatf("%-47s%s\n", objectors[obj].get_full_name(), objectors[obj].get_type_name())};
   end
   
   `uvm_info("WATCHDOG", str, UVM_LOW)*/
   
endfunction : objector_report


`endif // __UVML_WATCHDOG_SV__
