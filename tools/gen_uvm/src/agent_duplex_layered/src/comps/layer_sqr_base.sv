// Copyright ${year} ${name_of_copyright_owner}
// 
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.


`ifndef __UVMA_${name_uppercase}_LAYER_SQR_BASE_SV__
`define __UVMA_${name_uppercase}_LAYER_SQR_BASE_SV__


/**
 * Sequencer on which ${name_normal_case} sequences are run; provides sequence items to driver.
 */
class uvma_${name}_layer_sqr_base_c#(
   type T_IN   = uvm_sequence_item,
   type T_OUT  = uvm_sequence_item,
   type T_USQR = uvm_sequencer
) extends uvm_sequencer#(
   .REQ(T_OUT),
   .RSP(T_OUT)
);
   
   // Objects
   uvma_${name}_cfg_c    cfg;
   uvma_${name}_cntxt_c  cntxt;
   
   // Handle to upstream sequencer
   T_USQR  upstrm_sqr;
   
   // TLM
   uvm_analysis_port#(T_OUT)  ap;
   
   
   `uvm_component_param_utils_begin(uvma_${name}_layer_sqr_base_c#(T_IN, T_OUT, T_USQR))
      `uvm_field_object(cfg  , UVM_DEFAULT)
      `uvm_field_object(cntxt, UVM_DEFAULT)
   `uvm_component_utils_end
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvma_${name}_layer_sqr_base", uvm_component parent=null);
   
   /**
    * Ensures cfg & cntxt handles are not null.
    */
   extern virtual function void build_phase(uvm_phase phase);
   
endclass : uvma_${name}_layer_sqr_base_c


`pragma protect begin


function uvma_${name}_layer_sqr_base_c::new(string name="uvma_${name}_layer_sqr_base", uvm_component parent=null);
   
   super.new(name, parent);
   
endfunction : new


function void uvma_${name}_layer_sqr_base_c::build_phase(uvm_phase phase);
   
   super.build_phase(phase);
   
   void'(uvm_config_db#(uvma_${name}_cfg_c)::get(this, "", "cfg", cfg));
   if (!cfg) begin
      `uvm_fatal("CFG", "Configuration handle is null")
   end
   
   void'(uvm_config_db#(uvma_${name}_cntxt_c)::get(this, "", "cntxt", cntxt));
   if (!cntxt) begin
      `uvm_fatal("CNTXT", "Context handle is null")
   end
   
   ap = new("ap", this);
   
endfunction : build_phase


`pragma protect end


`endif // __UVMA_${name_uppercase}_LAYER_SQR_BASE_SV__
