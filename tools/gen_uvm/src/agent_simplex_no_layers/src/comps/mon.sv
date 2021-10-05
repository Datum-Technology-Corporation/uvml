// Copyright ${year} ${name_of_copyright_owner}
// 
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.


`ifndef __UVMA_${name_uppercase}_MON_SV__
`define __UVMA_${name_uppercase}_MON_SV__


/**
 * Component sampling transactions from a ${name_normal_case} virtual interface (uvma_${name}_if).
 */
class uvma_${name}_mon_c extends uvm_monitor;
   
   // Objects
   uvma_${name}_cfg_c    cfg;
   uvma_${name}_cntxt_c  cntxt;
   
   // TLM
   uvm_analysis_port#(uvma_${name}_mon_trn_c)  ap;
   
   // Handles to virtual interface modport(s)
   virtual uvma_${name}_if.mon_mp  mp;
   
   
   `uvm_component_utils_begin(uvma_${name}_mon_c)
      `uvm_field_object(cfg  , UVM_DEFAULT)
      `uvm_field_object(cntxt, UVM_DEFAULT)
   `uvm_component_utils_end
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvma_${name}_mon", uvm_component parent=null);
   
   /**
    * 1. Ensures cfg & cntxt handles are not null.
    * 2. Builds ap.
    */
   extern virtual function void build_phase(uvm_phase phase);
   
   /**
    * Oversees monitoring, depending on the reset state, by calling mon_<pre|in|post>_reset() tasks.
    */
   extern virtual task run_phase(uvm_phase phase);
   
   /**
    * Updates the context's reset state.
    */
   extern virtual task observe_reset();
   
   /**
    * Synchronous reset thread.
    */
   extern virtual task observe_reset_sync();
   
   /**
    * Asynchronous reset thread.
    */
   extern virtual task observe_reset_async();
   
   /**
    * Called by run_phase() while agent is in pre-reset state.
    */
   extern virtual task mon_pre_reset(uvm_phase phase);
   
   /**
    * Called by run_phase() while agent is in reset state.
    */
   extern virtual task mon_in_reset(uvm_phase phase);
   
   /**
    * Called by run_phase() while agent is in post-reset state.
    */
   extern virtual task mon_post_reset(uvm_phase phase);
   
   /**
    * Creates trn by sampling the virtual interface's (cntxt.vif) signals.
    */
   extern virtual task sample_trn(output uvma_${name}_mon_trn_c trn);
   
   /**
    * Prints out trn and issues heartbeat.
    */
   extern virtual function void process_trn(ref uvma_${name}_mon_trn_c trn);
   
endclass : uvma_${name}_mon_c


function uvma_${name}_mon_c::new(string name="uvma_${name}_mon", uvm_component parent=null);
   
   super.new(name, parent);
   
endfunction : new


function void uvma_${name}_mon_c::build_phase(uvm_phase phase);
   
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
   mp = cntxt.vif.mon_mp;
  
endfunction : build_phase


task uvma_${name}_mon_c::run_phase(uvm_phase phase);
   
   super.run_phase(phase);
   
   if (cfg.enabled) begin
      fork
         observe_reset();
         
         begin
            forever begin
               case (cntxt.reset_state)
                  UVMA_${name_uppercase}_RESET_STATE_PRE_RESET : mon_pre_reset (phase);
                  UVMA_${name_uppercase}_RESET_STATE_IN_RESET  : mon_in_reset  (phase);
                  UVMA_${name_uppercase}_RESET_STATE_POST_RESET: mon_post_reset(phase);
               endcase
            end
         end
      join_none
   end
   
endtask : run_phase


task uvma_${name}_mon_c::observe_reset();
   
   case (cfg.reset_mode)
      UVMA_${name_uppercase}_RESET_MODE_SYNCHRONOUS : observe_reset_sync ();
      UVMA_${name_uppercase}_RESET_MODE_ASYNCHRONOUS: observe_reset_async();
      
      default: begin
         `uvm_fatal("${name_uppercase}_MON", $sformatf("Illegal cfg.reset_mode: %s", cfg.reset_mode.name()))
      end
   endcase
   
endtask : observe_reset


task uvma_${name}_mon_c::observe_reset_sync();
   
   // TODO Implement uvma_${name}_mon_c::observe_reset_sync();
   //      Ex: forever begin
   //             while (cntxt.vif.reset_n !== 1'b0) begin
   //                wait (cntxt.vif.clk === 1);
   //                wait (cntxt.vif.clk === 0);
   //             end
   //             cntxt.reset_state = UVMA_${name_uppercase}_RESET_STATE_IN_RESET;
   //             `uvm_info("${name_uppecase}_MON", "Entered IN_RESET state", UVM_MEDIUM)
   //             
   //             while (cntxt.vif.reset_n !== 1'b1) begin
   //                wait (cntxt.vif.clk === 1);
   //                wait (cntxt.vif.clk === 0);
   //             end
   //             cntxt.reset_state = UVMA_${name_uppercase}_RESET_STATE_POST_RESET;
   //             `uvm_info("${name_uppecase}_MON", "Entered POST_RESET state", UVM_MEDIUM)
   //          end
   
endtask : observe_reset_sync


task uvma_${name}_mon_c::observe_reset_async();
   
   // TODO Implement uvma_${name}_mon_c::observe_reset_async();
   //      Ex: forever begin
   //             wait (cntxt.vif.reset_n === 0);
   //             cntxt.reset_state = UVMA_${name_uppercase}_RESET_STATE_IN_RESET;
   //             `uvm_info("${name_uppecase}_MON", "Entered IN_RESET state", UVM_MEDIUM)
   //
   //             wait (cntxt.vif.reset_n === 1);
   //             cntxt.reset_state = UVMA_${name_uppercase}_RESET_STATE_POST_RESET;
   //             `uvm_info("${name_uppecase}_MON", "Entered POST_RESET state", UVM_MEDIUM)
   //          end
   
endtask : observe_reset_async


task uvma_${name}_mon_c::mon_pre_reset(uvm_phase phase);
   
   // TODO Implement uvma_${name}_mon_c::mon_pre_reset()
   //      Ex: @(mp.mon_cb);
   
   // WARNING If no time is consumed by this task, a zero-delay oscillation loop will occur and stall simulation
   
endtask : mon_pre_reset


task uvma_${name}_mon_c::mon_in_reset(uvm_phase phase);
   
   // TODO Implement uvma_${name}_mon_c::mon_in_reset()
   //      Ex: @(mp.mon_cb);
   
   // WARNING If no time is consumed by this task, a zero-delay oscillation loop will occur and stall simulation
   
endtask : mon_in_reset


task uvma_${name}_mon_c::mon_post_reset(uvm_phase phase);
   
   uvma_${name}_mon_trn_c  trn;
   
   sample_trn (trn);
   process_trn(trn);
   ap.write   (trn);
   
endtask : mon_post_reset


task uvma_${name}_mon_c::sample_trn(output uvma_${name}_mon_trn_c trn);
   
   bit  sampled_trn = 0;
   
   trn = uvma_${name}_mon_trn_c::type_id::create("trn");
   
   do begin
      @(cntxt.vif.mon_cb);
      
      // TODO Sample trn from vif
      //      Ex: if (mp.mon_cb.enable) begin
      //          sampled_trn   = 1;
      //          trn.abc       = mp.mon_cb.abc;
      //          trn.xyz       = mp.mon_cb.xyz;
      //          trn.timestamp = $realtime();
      //          end
      
      // WARNING If no time is consumed by this loop, a zero-delay oscillation loop will occur and stall simulation
   end while (!sampled_trn);
   
endtask : sample_trn


function void uvma_${name}_mon_c::process_trn(ref uvma_${name}_mon_trn_c trn);
   
   `uvm_info("${name_uppecase}_MON", $sformatf("Sampled transaction from the virtual interface:\n%s", trn.sprint(), UVM_HIGH)
   `uvml_hrtbt()
   
endfunction : process_trn


`endif // __UVMA_${name_uppercase}_MON_SV__
