// Copyright ${year} ${name_of_copyright_owner}
// 
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.


`ifndef __UVME_${name_uppercase}_VSQR_SV__
`define __UVME_${name_uppercase}_VSQR_SV__


/**
 * Component on which all ${name_normal_case} virtual sequences are run.
 */
class uvme_${name}_vsqr_c extends uvm_sequencer#(
   .REQ(uvm_sequence_item),
   .RSP(uvm_sequence_item)
);
   
   // Objects
   uvme_${name}_cfg_c    cfg;
   uvme_${name}_cntxt_c  cntxt;
   
   // Sub-environments (virtual) sequencer handles
   // TODO: Add sub-environments (virtual) sequencer handles
   //       Ex: uvme_sub_env_vsqr_c  sub_env_vsequencer;
   
   // Sequencer handles
   uvma_${clk_agent_type}_sqr_c  ${clk_agent_name}_sequencer;
   uvma_${reset_agent_type}_sqr_c  ${reset_agent_name}_sequencer;
   uvma_${ral_agent_type}_sqr_c  ${ral_agent_name}_sequencer;
   // TODO Add sequencer handles
   
   
   `uvm_component_utils_begin(uvme_${name}_vsqr_c)
      `uvm_field_object(cfg  , UVM_DEFAULT)
      `uvm_field_object(cntxt, UVM_DEFAULT)
   `uvm_component_utils_end
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvme_${name}_sqr", uvm_component parent=null);
   
   /**
    * Ensures cfg & cntxt handles are not null.
    */
   extern virtual function void build_phase(uvm_phase phase);
   
endclass : uvme_${name}_vsqr_c


`pragma protect begin


function uvme_${name}_vsqr_c::new(string name="uvme_${name}_sqr", uvm_component parent=null);
   
   super.new(name, parent);
   
endfunction : new


function void uvme_${name}_vsqr_c::build_phase(uvm_phase phase);
   
   super.build_phase(phase);
   
   void'(uvm_config_db#(uvme_${name}_cfg_c)::get(this, "", "cfg", cfg));
   if (!cfg) begin
      `uvm_fatal("CFG", "Configuration handle is null")
   end
   
   void'(uvm_config_db#(uvme_${name}_cntxt_c)::get(this, "", "cntxt", cntxt));
   if (!cntxt) begin
      `uvm_fatal("CNTXT", "Context handle is null")
   end
   
endfunction : build_phase


`pragma protect end


`endif // __UVME_${name_uppercase}_VSQR_SV__
