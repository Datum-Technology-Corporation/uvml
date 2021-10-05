// Copyright ${year} ${name_of_copyright_owner}
// 
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.


`ifndef __UVMA_${name_uppercase}_DRV_SV__
`define __UVMA_${name_uppercase}_DRV_SV__


/**
 * Component driving a ${name_normal_case} virtual interface (uvma_${name}_if).
 */
class uvma_${name}_drv_c extends uvm_driver#(
   .REQ(uvma_${name}_seq_item_c),
   .RSP(uvma_${name}_seq_item_c)
);
   
   // Objects
   uvma_${name}_cfg_c    cfg;
   uvma_${name}_cntxt_c  cntxt;
   
   // TLM
   uvm_analysis_port#(uvma_${name}_seq_item_c)  ap;
   
   // Handles to virtual interface modport(s)
   virtual uvma_${name}_if.drv_mp  mp;
   
   
   `uvm_component_utils_begin(uvma_${name}_drv_c)
      `uvm_field_object(cfg  , UVM_DEFAULT)
      `uvm_field_object(cntxt, UVM_DEFAULT)
   `uvm_component_utils_end
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvma_${name}_drv", uvm_component parent=null);
   
   /**
    * 1. Ensures cfg & cntxt handles are not null.
    * 2. Builds ap.
    */
   extern virtual function void build_phase(uvm_phase phase);
   
   /**
    * Oversees driving, depending on the reset state, by calling drv_<pre|in|post>_reset() tasks.
    */
   extern virtual task run_phase(uvm_phase phase);
   
   /**
    * Called by run_phase() while agent is in pre-reset state.
    */
   extern virtual task drv_pre_reset(uvm_phase phase);
   
   /**
    * Called by run_phase() while agent is in reset state.
    */
   extern virtual task drv_in_reset(uvm_phase phase);
   
   /**
    * Called by run_phase() while agent is in post-reset state.
    */
   extern virtual task drv_post_reset(uvm_phase phase);
   
   /**
    * Drives the virtual interface's (cntxt.vif) signals using req's contents.
    */
   extern virtual task drv_req(ref uvma_${name}_seq_item_c req);
   
endclass : uvma_${name}_drv_c


function uvma_${name}_drv_c::new(string name="uvma_${name}_drv", uvm_component parent=null);
   
   super.new(name, parent);
   
endfunction : new


function void uvma_${name}_drv_c::build_phase(uvm_phase phase);
   
   super.build_phase(phase);
   
   void'(uvm_config_db#(uvma_${name}_cfg_c)::get(this, "", "cfg", cfg));
   if (!cfg) begin
      `uvm_fatal("CFG", "Configuration handle is null")
   end
   uvm_config_db#(uvma_${name}_cfg_c)::set(this, "*", "cfg", cfg);
   
   void'(uvm_config_db#(uvma_${name}_cntxt_c)::get(this, "", "cntxt", cntxt));
   if (!cntxt) begin
      `uvm_fatal("CNTXT", "Context handle is null")
   end
   uvm_config_db#(uvma_${name}_cntxt_c)::set(this, "*", "cntxt", cntxt);
   
   ap = new("ap", this);
   mp = cntxt.vif.drv_mp;
   
endfunction : build_phase


task uvma_${name}_drv_c::run_phase(uvm_phase phase);
   
   super.run_phase(phase);
   
   if (cfg.enabled && cfg.is_active) begin
      forever begin
         case (cntxt.reset_state)
            UVMA_${name_uppercase}_RESET_STATE_PRE_RESET : drv_pre_reset (phase);
            UVMA_${name_uppercase}_RESET_STATE_IN_RESET  : drv_in_reset  (phase);
            UVMA_${name_uppercase}_RESET_STATE_POST_RESET: drv_post_reset(phase);
         endcase
      end
   end
   
endtask : run_phase


task uvma_${name}_drv_c::drv_pre_reset(uvm_phase phase);
   
   // TODO Implement uvma_${name}_drv_c::drv_pre_reset()
   //      Ex: @(mp.drv_cb);
   
   // WARNING If no time is consumed by this task, a zero-delay oscillation loop will occur and stall simulation
   
endtask : drv_pre_reset


task uvma_${name}_drv_c::drv_in_reset(uvm_phase phase);
   
   // TODO Implement uvma_${name}_drv_c::drv_in_reset()
   //      Ex: @(mp.drv_cb);
   
   // WARNING If no time is consumed by this task, a zero-delay oscillation loop will occur and stall simulation
   
endtask : drv_in_reset


task uvma_${name}_drv_c::drv_post_reset(uvm_phase phase);
   
   seq_item_port.get_next_item(req);
   `uvml_hrtbt()
   
   drv_req (req);
   ap.write(req);
   seq_item_port.item_done();
   
endtask : drv_post_reset


task uvma_${name}_drv_c::drv_req(ref uvma_${name}_seq_item_c req);
   
   // TODO Implement uvma_${name}_drv_c::drv_req()
   //      Ex: mp.drv_cb.abc <= req.abc;
   //          mp.drv_cb.xyz <= req.xyz;
   
   // WARNING If no time is consumed by this task, a zero-delay oscillation loop will occur and stall simulation
   
endtask : drv_req


`endif // __UVMA_${name_uppercase}_DRV_SV__
