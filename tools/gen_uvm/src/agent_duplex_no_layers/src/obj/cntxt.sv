// Copyright ${year} ${name_of_copyright_owner}
// 
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.


`ifndef __UVMA_${name_uppercase}_CNTXT_SV__
`define __UVMA_${name_uppercase}_CNTXT_SV__


/**
 * Object encapsulating all state variables for all ${name_normal_case} agent
 * (uvma_${name}_agent_c) components in both directions.
 */
class uvma_${name}_cntxt_c extends uvm_object;
   
   // Handle to agent interfaces
   virtual uvma_${name}_if  vif;
   
   // Coverage triggers
   uvm_event  sample_cfg_e;
   uvm_event  sample_cntxt_e;
   
   // Reset
   uvma_${name}_reset_state_enum  reset_state = UVMA_${name_uppercase}_RESET_STATE_PRE_RESET;
   
   // Sub-contexts
   uvma_${name}_cntxt_simplex_c  ${direction_rx}_cntxt;
   uvma_${name}_cntxt_simplex_c  ${direction_tx}_cntxt;
   
   
   `uvm_object_utils_begin(uvma_${name}_cntxt_c)
      `uvm_field_event(sample_cfg_e  , UVM_DEFAULT)
      `uvm_field_event(sample_cntxt_e, UVM_DEFAULT)
      
      `uvm_field_enum(uvma_${name}_reset_state_enum, reset_state, UVM_DEFAULT)
      
      `uvm_field_object(${direction_rx}_cntxt, UVM_DEFAULT)
      `uvm_field_object(${direction_tx}_cntxt, UVM_DEFAULT)
   `uvm_object_utils_end
   
   
   /**
    * Builds events and sub-context objects.
    */
   extern function new(string name="uvma_${name}_cntxt");
   
   /**
    * Reset child context objects.
    */
   extern function void reset();
   
endclass : uvma_${name}_cntxt_c


`pragma protect begin


function uvma_${name}_cntxt_c::new(string name="uvma_${name}_cntxt");
   
   super.new(name);
   
   sample_cfg_e   = new("sample_cfg_e"  );
   sample_cntxt_e = new("sample_cntxt_e");
   
   ${direction_rx}_cntxt = uvma_${name}_cntxt_simplex_c::type_id::create("${direction_rx}_cntxt");
   ${direction_tx}_cntxt = uvma_${name}_cntxt_simplex_c::type_id::create("${direction_tx}_cntxt");
   
   ${direction_rx}_cntxt.parent_cntxt = this;
   ${direction_tx}_cntxt.parent_cntxt = this;
   
endfunction : new


function void uvma_${name}_cntxt_c::reset();
   
   ${direction_rx}_cntxt.reset();
   ${direction_tx}_cntxt.reset();
   
endfunction : reset


`pragma protect end


`endif // __UVMA_${name_uppercase}_CNTXT_SV__
