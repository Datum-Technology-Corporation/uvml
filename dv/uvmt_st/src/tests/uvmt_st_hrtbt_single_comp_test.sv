// Copyright 2021 Datum Technology Corporation
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMT_ST_HRTBT_SINGLE_COMP_TEST_SV__
`define __UVMT_ST_HRTBT_SINGLE_COMP_TEST_SV__


/**
 * Checks that heartbeat monitor can handle one component's heartbeats.  In this case, the one component is the test
 * itself.
 */
class uvmt_st_hrtbt_single_comp_test_c extends uvmt_st_base_test_c;
   
   realtime  min_duration      ;
   bit       enough_time_passed;
   bit       issued_hrtbts     ;
   bit       main_phase_started;
   bit       main_phase_ended  ;
   
   
   `uvm_component_utils(uvmt_st_hrtbt_single_comp_test_c)
   
   /**
    * Creates single_comp_vseq.
    */
   extern function new(string name="uvmt_st_hrtbt_single_comp_test", uvm_component parent=null);
   
   /**
    * Issues single heartbeat to ensure startup timeout feature doesn't fail test.
    */
   extern virtual task run_phase(uvm_phase phase);
   
   /**
    * Issues multiple heartbeats.
    */
   extern virtual task main_phase(uvm_phase phase);
   
   /**
    * Issues event for self-checking.
    */
   extern virtual task post_main_phase(uvm_phase phase);
   
   /**
    * Checks that the test doesn't end before the expected time.
    */
   extern virtual function void check_phase(uvm_phase phase);
   
endclass : uvmt_st_hrtbt_single_comp_test_c


function uvmt_st_hrtbt_single_comp_test_c::new(string name="uvmt_st_hrtbt_single_comp_test", uvm_component parent=null);
   
   super.new(name, parent);
   
endfunction : new


task uvmt_st_hrtbt_single_comp_test_c::run_phase(uvm_phase phase);
   
   super.run_phase(phase);
   
   // Initialize variables
   min_duration = test_cfg.num_heartbeats * test_cfg.heartbeat_period * 1ns;
   enough_time_passed = 0;
   issued_hrtbts      = 0;
   main_phase_started = 0;
   main_phase_ended   = 0;
   
   #($urandom_range(0, test_cfg.startup_timeout) * 1ns);
   `uvml_time_hrtbt()
   
   wait (main_phase_started);
   `uvm_info("TEST", $sformatf("Checking that test does not end before %0t", min_duration), UVM_NONE)
   fork
      begin
         #(min_duration);
         enough_time_passed = 1;
         `uvm_info("TEST", $sformatf("Test did not end before %0t", min_duration), UVM_NONE)
      end
      
      begin
         wait (main_phase_ended);
      end
   join_any
   disable fork;
   
endtask : run_phase


task uvmt_st_hrtbt_single_comp_test_c::main_phase(uvm_phase phase);
   
   super.main_phase(phase);
   
   phase.raise_objection(this);
   `uvm_info("TEST", $sformatf("Starting test stimulus:\n%s", test_cfg.sprint()), UVM_NONE)
   main_phase_started = 1;
   #1ns; // Waiting for an amount of time greater than 0 to avoid race condition for checking in run_phase() to work
   
   // Test Scenario
   for (int unsigned ii=0; ii<test_cfg.num_heartbeats; ii++) begin
      `uvml_time_hrtbt()
      `uvm_info("TEST", $sformatf("Issued heartbeat %0d of %0d", ii+1, test_cfg.num_heartbeats), UVM_NONE)
   end
   issued_hrtbts = 1;

   `uvm_info("TEST", $sformatf("Finished test stimulus:\n%s", test_cfg.sprint()), UVM_NONE)
   phase.drop_objection(this);
   
endtask : main_phase


task uvmt_st_hrtbt_single_comp_test_c::post_main_phase(uvm_phase phase);
   
   super.post_main_phase(phase);
   main_phase_ended = 1;
   
endtask : post_main_phase



function void uvmt_st_hrtbt_single_comp_test_c::check_phase(uvm_phase phase);
  
   super.check_phase(phase);
  
   // Checks
   if (!enough_time_passed) begin
      `uvm_error("TEST", $sformatf("Test ended before %0t passed", min_duration))
   end
   if (!issued_hrtbts) begin
      `uvm_error("TEST", "Test did not issue all heartbeats")
   end
  
endfunction : check_phase



`endif // __UVMT_ST_HRTBT_SINGLE_COMP_TEST_SV_
