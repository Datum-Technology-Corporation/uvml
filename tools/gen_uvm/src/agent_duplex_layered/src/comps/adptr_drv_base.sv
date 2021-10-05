// Copyright ${year} ${name_of_copyright_owner}
// 
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.


`ifndef __UVMA_${name_uppercase}_ADPTR_DRV_BASE_SV__
`define __UVMA_${name_uppercase}_ADPTR_DRV_BASE_SV__


/**
 * Abstract component from which all other ${name_normal_case} adapter drivers must extend.
 * Manages the run_phase() for both ${direction_rx_normal_case} and ${direction_tx_normal_case}.
 */
class uvma_${name}_adptr_drv_base_c#(
   type T_REQ = uvm_sequence_item,
   type T_RSP = uvm_sequence_item
) extends uvm_driver#(
   .REQ(T_REQ),
   .RSP(T_RSP)
);
   
   // Objects
   uvma_${name}_cfg_c    cfg;
   uvma_${name}_cntxt_c  cntxt;
   
   // TLM
   uvm_analysis_port#(T_REQ)  ap;
   
   
   `uvm_component_param_utils_begin(uvma_${name}_adptr_drv_base_c#(T_REQ, T_RSP))
      `uvm_field_object(cfg  , UVM_DEFAULT)
      `uvm_field_object(cntxt, UVM_DEFAULT)
   `uvm_component_utils_end
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvma_${name}_adptr_drv_base", uvm_component parent=null);
   
   /**
    * 1. Check for cfg and cntxt.
    * 2. Build TLM objects.
    */
   extern virtual function void build_phase(uvm_phase phase);
   
   /**
    * Oversees driving, depending on the reset state, by calling drv_<${direction_rx}|${direction_tx}>_<pre|in|post>_reset() tasks.
    */
   extern virtual task run_phase(uvm_phase phase);
   
   /**
    * Pure virtual hook called by run_phase() while agent is in pre-reset state.
    */
   extern virtual task drv_${direction_rx}_pre_reset();
   
   /**
    * Pure virtual hook called by run_phase() while agent is in pre-reset state.
    */
   extern virtual task drv_${direction_tx}_pre_reset();
   
   /**
    * Pure virtual hook called by run_phase() while agent is in reset state.
    */
   extern virtual task drv_${direction_rx}_in_reset();
   
   /**
    * Pure virtual hook called by run_phase() while agent is in reset state.
    */
   extern virtual task drv_${direction_tx}_in_reset();
   
   /**
    * Pure virtual hook called by run_phase() while agent is in post-reset state.
    */
   extern virtual task drv_${direction_rx}_post_reset();
   
   /**
    * Oversees the process of driving transactions onto the virtual interface (vif).
    * Called by run_phase() while agent is in post-reset state.
    */
   extern virtual task drv_${direction_tx}_post_reset();
   
   /**
    * Pure virtual hook called by drv_${direction_tx}_post_reset() when a sequence item is available.
    * Responsible for driving the virtual interface's (cntxt.vif) signals using req's contents.
    */
   extern virtual task drv_${direction_tx}_req(ref T_REQ req);
   
   /**
    * Pure virtual hook called by drv_${direction_tx}_post_reset() when no sequence item is available.
    * Responsible for driving the virtual interface's (cntxt.vif) signals during an idle cycle.
    */
   extern virtual task drv_${direction_tx}_idle();
   
endclass : uvma_${name}_adptr_drv_base_c


`pragma protect begin


function uvma_${name}_adptr_drv_base_c::new(string name="uvma_${name}_adptr_drv_base", uvm_component parent=null);
   
   super.new(name, parent);
   
endfunction : new


function void uvma_${name}_adptr_drv_base_c::build_phase(uvm_phase phase);
   
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


task uvma_${name}_adptr_drv_base_c::run_phase(uvm_phase phase);
   
   super.run_phase(phase);
   
   fork
      // ${direction_rx_normal_case}
      begin
         if (cfg.${direction_rx}_cfg.enabled) begin
            forever begin
               case (cntxt.reset_state)
                  UVMA_${name_uppercase}_RESET_STATE_PRE_RESET :  drv_${direction_rx}_pre_reset ();
                  UVMA_${name_uppercase}_RESET_STATE_IN_RESET  :  drv_${direction_rx}_in_reset  ();
                  UVMA_${name_uppercase}_RESET_STATE_POST_RESET:  drv_${direction_rx}_post_reset();
               endcase
            end
         end
      end
      
      // ${direction_tx_normal_case}
      begin
         if (cfg.${direction_tx}_cfg.enabled) begin
            forever begin
               case (cntxt.reset_state)
                  UVMA_${name_uppercase}_RESET_STATE_PRE_RESET : drv_${direction_tx}_pre_reset ();
                  UVMA_${name_uppercase}_RESET_STATE_IN_RESET  : drv_${direction_tx}_in_reset  ();
                  UVMA_${name_uppercase}_RESET_STATE_POST_RESET: drv_${direction_tx}_post_reset();
               endcase
            end
         end
      end
   join_none
   
endtask : run_phase


task uvma_${name}_adptr_drv_base_c::drv_${direction_rx}_pre_reset();
   
   `uvm_fatal("${name_uppercase}_DRV_${direction_rx_uppercase}", "Call to pure virtual task")
   
endtask : drv_${direction_rx}_pre_reset


task uvma_${name}_adptr_drv_base_c::drv_${direction_tx}_pre_reset();
   
   `uvm_fatal("${name_uppercase}_DRV_${direction_tx_uppercase}", "Call to pure virtual task")
   
endtask : drv_${direction_tx}_pre_reset


task uvma_${name}_adptr_drv_base_c::drv_${direction_rx}_in_reset();
   
   `uvm_fatal("${name_uppercase}_DRV_${direction_rx_uppercase}", "Call to pure virtual task")
   
endtask : drv_${direction_rx}_in_reset


task uvma_${name}_adptr_drv_base_c::drv_${direction_tx}_in_reset();
   
   `uvm_fatal("${name_uppercase}_DRV_${direction_tx_uppercase}", "Call to pure virtual task")
   
endtask : drv_${direction_tx}_in_reset


task uvma_${name}_adptr_drv_base_c::drv_${direction_rx}_post_reset();
   
   `uvm_fatal("${name_uppercase}_DRV_${direction_rx_uppercase}", "Call to pure virtual task")
   
endtask : drv_${direction_rx}_post_reset


task uvma_${name}_adptr_drv_base_c::drv_${direction_tx}_post_reset();
   
   // Non-blocking; returns immediately if no sequence item is available
   seq_item_port.try_next_item(req);
   
   // We still need to drive the interface (or simply consume a clock cycle) if no item is available (i.e. null)
   if (req == null) begin
      drv_${direction_tx}_idle();
   end
   else begin
      // Physically drive the wires of the interface with the contents of req
      drv_${direction_tx}_req(req);
      
      // Reset the heartbeat monitor timer
      `uvm_hrtbt()
      
      // Write req out onto the analysis port
      ap.write(req);
      
      // Indicate to the sequencer/sequence that we are done with this item
      seq_item_port.item_done(
         // TODO Will the req be sent back to the sequencer/sequence? If so, uncomment the following line
         //      req
      );
   end
   
endtask : drv_${direction_tx}_post_reset


task uvma_${name}_adptr_drv_base_c::drv_${direction_tx}_req(ref T_REQ req);
   
   `uvm_fatal("${name_uppercase}_DRV_${direction_tx_uppercase}", "Call to pure virtual task")
   
endtask : drv_${direction_tx}_req


task uvma_${name}_adptr_drv_base_c::drv_${direction_tx}_idle();
   
   `uvm_fatal("${name_uppercase}_DRV_${direction_tx_uppercase}", "Call to pure virtual task")
   
endtask : drv_${direction_tx}_idle


`pragma protect end


`endif // __UVMA_${name_uppercase}_ADPTR_DRV_BASE_SV__
