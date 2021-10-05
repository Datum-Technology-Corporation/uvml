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
 * Component driving a ${name_normal_case} virtual interface
 * (uvma_${name}_if) in both directions.
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
   
   
   `uvm_component_utils_begin(uvma_${name}_drv_c)
      `uvm_field_object(cfg  , UVM_DEFAULT)
      `uvm_field_object(cntxt, UVM_DEFAULT)
   `uvm_component_utils_end
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvma_${name}_drv", uvm_component parent=null);
   
   /**
    * Retrieves cfg and cntxt.
    */
   extern virtual function void build_phase(uvm_phase phase);
   
   /**
    * Oversees driving, depending on the reset state, by calling
    * drv_<${direction_rx}|${direction_tx}>_<pre|in|post>_reset() tasks.
    */
   extern virtual task run_phase(uvm_phase phase);
   
   /**
    * TODO Describe uvma_${name}_drv_c::drv_${direction_rx}_pre_reset()
    */
   extern virtual task drv_${direction_rx}_pre_reset(uvm_phase phase);
   
   /**
    * TODO Describe uvma_${name}_drv_c::drv_${direction_tx}_pre_reset()
    */
   extern virtual task drv_${direction_tx}_pre_reset(uvm_phase phase);
   
   /**
    * TODO Describe uvma_${name}_drv_c::drv_${direction_rx}_in_reset()
    */
   extern virtual task drv_${direction_rx}_in_reset(uvm_phase phase);
   
   /**
    * TODO Describe uvma_${name}_drv_c::drv_${direction_tx}_in_reset()
    */
   extern virtual task drv_${direction_tx}_in_reset(uvm_phase phase);
   
   /**
    * TODO Describe uvma_${name}_drv_c::drv_${direction_rx}_post_reset()
    */
   extern virtual task drv_${direction_rx}_post_reset(uvm_phase phase);
   
   /**
    * TODO Describe uvma_${name}_drv_c::drv_${direction_tx}_post_reset()
    */
   extern virtual task drv_${direction_tx}_post_reset(uvm_phase phase);
   
   /**
    * TODO Describe uvma_${name}_drv_c::drv_${direction_tx}_req()
    */
   extern virtual task drv_${direction_tx}_req(ref uvma_${name}_seq_item_c req);
   
   /**
    * TODO Describe uvma_${name}_drv_c::drv_${direction_tx}_idle()
    */
   extern virtual task drv_${direction_tx}_idle();
   
endclass : uvma_${name}_drv_c


`pragma protect begin


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
   
endfunction : build_phase


task uvma_${name}_drv_c::run_phase(uvm_phase phase);
   
   super.run_phase(phase);
   
   fork
      // ${direction_rx_normal_case}
      begin
         forever begin
            wait (cfg.enabled && cfg.is_active && cfg.${direction_rx}_cfg.enabled);
            case (cntxt.reset_state)
               UVMA_${name_uppercase}_RESET_STATE_PRE_RESET :  drv_${direction_rx}_pre_reset (phase);
               UVMA_${name_uppercase}_RESET_STATE_IN_RESET  :  drv_${direction_rx}_in_reset  (phase);
               UVMA_${name_uppercase}_RESET_STATE_POST_RESET:  drv_${direction_rx}_post_reset(phase);
            endcase
         end
      end
      
      // ${direction_tx_normal_case}
      begin
         forever begin
            wait (cfg.enabled && cfg.is_active && cfg.${direction_tx}_cfg.enabled);
            case (cntxt.reset_state)
               UVMA_${name_uppercase}_RESET_STATE_PRE_RESET : drv_${direction_tx}_pre_reset (phase);
               UVMA_${name_uppercase}_RESET_STATE_IN_RESET  : drv_${direction_tx}_in_reset  (phase);
               UVMA_${name_uppercase}_RESET_STATE_POST_RESET: drv_${direction_tx}_post_reset(phase);
            endcase
         end
      end
   join_none
   
endtask : run_phase


task uvma_${name}_drv_c::drv_${direction_rx}_pre_reset(uvm_phase phase);
   
   // TODO Implement uvma_${name}_drv_c::drv_${direction_rx}_pre_reset()
   //      Ex: @(cntxt.vif.drv_${direction_rx}_cb);
   
   // WARNING If no time is consumed by this task, a zero-delay oscillation loop will occur and stall simulation
   
endtask : drv_${direction_rx}_pre_reset


task uvma_${name}_drv_c::drv_${direction_tx}_pre_reset(uvm_phase phase);
   
   // TODO Implement uvma_${name}_drv_c::drv_${direction_tx}_pre_reset()
   //      Ex: @(cntxt.vif.drv_${direction_tx}_cb);
   
   // WARNING If no time is consumed by this task, a zero-delay oscillation loop will occur and stall simulation
   
endtask : drv_${direction_tx}_pre_reset


task uvma_${name}_drv_c::drv_${direction_rx}_in_reset(uvm_phase phase);
   
   // TODO Implement uvma_${name}_drv_c::drv_${direction_rx}_in_reset()
   //      Ex: @(cntxt.vif.drv_${direction_rx}_cb);
   
   // WARNING If no time is consumed by this task, a zero-delay oscillation loop will occur and stall simulation
   
endtask : drv_${direction_rx}_in_reset


task uvma_${name}_drv_c::drv_${direction_tx}_in_reset(uvm_phase phase);
   
   // TODO Implement uvma_${name}_drv_c::drv_${direction_tx}_in_reset()
   //      Ex: @(cntxt.vif.drv_${direction_tx}_cb);
   
   // WARNING If no time is consumed by this task, a zero-delay oscillation loop will occur and stall simulation
   
endtask : drv_${direction_tx}_in_reset


task uvma_${name}_drv_c::drv_${direction_rx}_post_reset(uvm_phase phase);
   
   // TODO Implement uvma_${name}_drv_c::drv_${direction_rx}_post_reset()
   //      Ex: @(cntxt.vif.drv_${direction_rx}_cb);
   //          cntxt.vif.drv_${direction_rx}_cb.${direction_rx}_ready <= 1;
   
   // WARNING If no time is consumed by this task, a zero-delay oscillation loop will occur and stall simulation
   
endtask : drv_${direction_rx}_post_reset


task uvma_${name}_drv_c::drv_${direction_tx}_post_reset(uvm_phase phase);
   
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


task uvma_${name}_drv_c::drv_${direction_tx}_req(ref uvma_${name}_seq_item_c req);
   
   `uvm_info("${name_uppercase}_DRV", $sformatf("Got new req from sequencer:\n%s", req.sprint()), UVM_HIGH)
   
   // TODO Implement uvma_${name}_drv_c::drv_${direction_tx}_req()
   //      Ex: @(cntxt.vif.drv_${direction_tx}_cb);
   //          if (cntxt.vif.drv_${direction_tx}_cb.${direction_tx}_ready) begin
   //             cntxt.vif.drv_${direction_tx}_cb.${direction_tx}_abc <= req.abc;
   //             cntxt.vif.drv_${direction_tx}_cb.${direction_tx}_xyz <= req.xyz;
   //          end
   
   // WARNING If no time is consumed by this task, a zero-delay oscillation loop will occur and stall simulation
   
endtask : drv_${direction_tx}_req


task uvma_${name}_drv_c::drv_${direction_tx}_idle();
   
   // TODO Implement uvma_${name}_drv_c::drv_${direction_tx}_req()
   //      Ex: @(cntxt.vif.drv_${direction_tx}_cb);
   
   // WARNING If no time is consumed by this task, a zero-delay oscillation loop will occur and stall simulation
   
endtask : drv_${direction_tx}_idle


`pragma protect end


`endif // __UVMA_${name_uppercase}_DRV_SV__
