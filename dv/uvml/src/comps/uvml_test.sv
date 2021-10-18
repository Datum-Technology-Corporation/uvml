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


`ifndef __UVML_TEST_SV__
`define __UVML_TEST_SV__


/**
 * TODO Describe uvml_test_c
 */
class uvml_test_c /*#(
   type T_TEST_CFG
)*/ extends uvm_test;
   
   // Objects
   //rand T_TEST_CFG  cfg;
   
   
   `uvm_component_utils_begin(uvml_test_c)
      
   `uvm_component_utils_end
   
   
   // Constraints
   
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvml_test", uvm_component parent=null);
   
   // Methods
   
   
endclass : uvml_test_c


function uvml_test_c::new(string name="uvml_test", uvm_component parent=null);
   
   super.new(name, parent);
   
endfunction : new

/*
function void uvml_test_c::phase_started(uvm_phase phase);
   
   super.phase_started(phase);
   print_banner($sformatf("start of %s phase", phase.get_name()));
   
endfunction : phase_started


function void uvml_test_c::phase_ended(uvm_phase phase);
   
   super.phase_ended(phase);
   
   if (phase.is(uvm_final_phase::get())) begin
      uvm_config_db#(bit)::set(null, "", "sim_finished", 1);
      print_banner("test finished");
   end
   
endfunction : phase_ended


function void uvml_test_c::print_banner(string text);
   
   $display("");
   $display("*******************************************************************************");
   $display(text.toupper());
   $display("*******************************************************************************");
   
endfunction : print_banner
*/

`endif // __UVML_TEST_SV__
