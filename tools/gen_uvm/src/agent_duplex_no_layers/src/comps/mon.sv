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
 * Component sampling transactions from a ${name_normal_case} virtual interface
 * (uvma_${name}_if) in both directions.
 */
class uvma_${name}_mon_c extends uvm_monitor;
   
   // Objects
   uvma_${name}_cfg_c    cfg;
   uvma_${name}_cntxt_c  cntxt;
   
   // TLM
   uvm_analysis_port#(uvma_${name}_mon_trn_c)  ${direction_rx}_ap;
   uvm_analysis_port#(uvma_${name}_mon_trn_c)  ${direction_tx}_ap;
   
   
   `uvm_component_utils_begin(uvma_${name}_mon_c)
      `uvm_field_object(cfg  , UVM_DEFAULT)
      `uvm_field_object(cntxt, UVM_DEFAULT)
   `uvm_component_utils_end
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvma_${name}_mon", uvm_component parent=null);
   
   /**
    * Retrieves cfg and cntxt.
    */
   extern virtual function void build_phase(uvm_phase phase);
   
   /**
    * Oversees monitoring, depending on the reset state, by calling
    * mon_<${direction_rx}|${direction_tx}>_<pre|in|post>_reset() tasks.
    */
   extern virtual task run_phase(uvm_phase phase);
   
   /**
    * TODO Describe uvma_${name}_mon_c::observe_reset()
    */
   extern virtual task observe_reset();
   
   /**
    * TODO Describe uvma_${name}_mon_c::mon_${direction_rx}_pre_reset()
    */
   extern virtual task mon_${direction_rx}_pre_reset(uvm_phase phase);
   
   /**
    * TODO Describe uvma_${name}_mon_c::mon_${direction_tx}_pre_reset()
    */
   extern virtual task mon_${direction_tx}_pre_reset(uvm_phase phase);
   
   /**
    * TODO Describe uvma_${name}_mon_c::mon_${direction_rx}_in_reset()
    */
   extern virtual task mon_${direction_rx}_in_reset(uvm_phase phase);
   
   /**
    * TODO Describe uvma_${name}_mon_c::mon_${direction_tx}_in_reset()
    */
   extern virtual task mon_${direction_tx}_in_reset(uvm_phase phase);
   
   /**
    * TODO Describe uvma_${name}_mon_c::mon_${direction_rx}_post_reset()
    */
   extern virtual task mon_${direction_rx}_post_reset(uvm_phase phase);
   
   /**
    * TODO Describe uvma_${name}_mon_c::mon_${direction_tx}_post_reset()
    */
   extern virtual task mon_${direction_tx}_post_reset(uvm_phase phase);
   
   /**
    * TODO Describe uvma_${name}_mon_c::sample_${direction_rx}_traffic()
    */
   extern virtual task sample_${direction_rx}_traffic(ref uvma_${name}_mon_trn_c trn);
   
   /**
    * TODO Describe uvma_${name}_mon_c::sample_${direction_tx}_traffic()
    */
   extern virtual task sample_${direction_tx}_traffic(ref uvma_${name}_mon_trn_c trn);
   
   /**
    * TODO Describe uvma_${name}_mon_c::process_${direction_rx}_traffic
    */
   extern virtual task process_${direction_rx}_traffic(ref uvma_${name}_mon_trn_c trn);
   
   /**
    * TODO Describe uvma_${name}_mon_c::process_${direction_tx}_traffic
    */
   extern virtual task process_${direction_tx}_traffic(ref uvma_${name}_mon_trn_c trn);
   
endclass : uvma_${name}_mon_c


`pragma protect begin


function uvma_${name}_mon_c::new(string name="uvma_${name}_mon", uvm_component parent=null);
   
   super.new(name, parent);
   
endfunction : new


function void uvma_${name}_mon_c::build_phase(uvm_phase phase);
   
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
   
   ${direction_rx}_ap = new("${direction_rx}_ap", this);
   ${direction_tx}_ap = new("${direction_tx}_ap", this);
   
endfunction : build_phase


task uvma_${name}_mon_c::run_phase(uvm_phase phase);
   
   super.run_phase(phase);
   
   fork
      begin
         observe_reset();
      end
      
      // ${direction_rx_normal_case}
      begin
         wait (cfg.enabled && cfg.${direction_rx}_cfg.enabled);
         forever begin
            case (cntxt.reset_state)
               UVMA_${name_uppercase}_RESET_STATE_PRE_RESET :  mon_${direction_rx}_pre_reset (phase);
               UVMA_${name_uppercase}_RESET_STATE_IN_RESET  :  mon_${direction_rx}_in_reset  (phase);
               UVMA_${name_uppercase}_RESET_STATE_POST_RESET:  mon_${direction_rx}_post_reset(phase);
            endcase
         end
      end
      
      // ${direction_tx_normal_case}
      begin
         wait (cfg.enabled && cfg.${direction_tx}_cfg.enabled);
         forever begin
            case (cntxt.reset_state)
               UVMA_${name_uppercase}_RESET_STATE_PRE_RESET :  mon_${direction_tx}_pre_reset (phase);
               UVMA_${name_uppercase}_RESET_STATE_IN_RESET  :  mon_${direction_tx}_in_reset  (phase);
               UVMA_${name_uppercase}_RESET_STATE_POST_RESET:  mon_${direction_tx}_post_reset(phase);
            endcase
         end
      end
   join_none
   
endtask : run_phase


task uvma_${name}_mon_c::observe_reset();
   
   // TODO Implement uvma_${name}_mon_c::observe_reset()
   //      Ex: forever begin
   //             wait (cfg.enabled);
   //             wait (cntxt.vif.reset == 1);
   //             cntxt.reset_state = UVMA_${name_uppercase}_RESET_STATE_IN_RESET;
   //             wait (cntxt.vif.reset == 0);
   //             cntxt.reset_state = UVMA_${name_uppercase}_RESET_STATE_POST_RESET;
   //          end
   
   // WARNING If no time is consumed by this task, a zero-delay oscillation loop will occur and stall simulation
   
endtask : observe_reset


task uvma_${name}_mon_c::mon_${direction_rx}_pre_reset(uvm_phase phase);
   
   // TODO Implement uvma_${name}_mon_c::mon_${direction_rx}_pre_reset()
   //      Ex: @(cntxt.vif.mon_${direction_rx}_cb);
   
   // WARNING If no time is consumed by this task, a zero-delay oscillation loop will occur and stall simulation
   
endtask : mon_${direction_rx}_pre_reset


task uvma_${name}_mon_c::mon_${direction_tx}_pre_reset(uvm_phase phase);
   
   // TODO Implement uvma_${name}_mon_c::mon_${direction_tx}_pre_reset()
   //      Ex: @(cntxt.vif.mon_${direction_tx}_cb);
   
   // WARNING If no time is consumed by this task, a zero-delay oscillation loop will occur and stall simulation
   
endtask : mon_${direction_tx}_pre_reset


task uvma_${name}_mon_c::mon_${direction_rx}_in_reset(uvm_phase phase);
   
   // TODO Implement uvma_${name}_mon_c::mon_${direction_rx}_in_reset()
   //      Ex: @(cntxt.vif.mon_${direction_rx}_cb);
   
   // WARNING If no time is consumed by this task, a zero-delay oscillation loop will occur and stall simulation
   
endtask : mon_${direction_rx}_in_reset


task uvma_${name}_mon_c::mon_${direction_tx}_in_reset(uvm_phase phase);
   
   // TODO Implement uvma_${name}_mon_c::mon_${direction_tx}_in_reset()
   //      Ex: @(cntxt.vif.mon_${direction_tx}_cb);
   
   // WARNING If no time is consumed by this task, a zero-delay oscillation loop will occur and stall simulation
   
endtask : mon_${direction_tx}_in_reset


task uvma_${name}_mon_c::mon_${direction_rx}_post_reset(uvm_phase phase);
   
   uvma_${name}_mon_trn_c  trn;
   
   // Sample values from vif into transaction
   sample_${direction_rx}_traffic(trn);
   
   // Process transaction (parsing, error checking, etc.)
   process_${direction_rx}_traffic(trn);
   
   // Send transaction out onto the analysis port
   ${direction_rx}_ap.write(trn);
   
endtask : mon_${direction_rx}_post_reset


task uvma_${name}_mon_c::mon_${direction_tx}_post_reset(uvm_phase phase);
   
   uvma_${name}_mon_trn_c  trn;
   
   // Sample values from vif into transaction
   sample_${direction_tx}_traffic(trn);
   
   // Process transaction (parsing, error checking, etc.)
   process_${direction_tx}_traffic(trn);
   
   // Send transaction out onto the analysis port
   ${direction_tx}_ap.write(trn);
   
endtask : mon_${direction_tx}_post_reset


task uvma_${name}_mon_c::sample_${direction_rx}_traffic(ref uvma_${name}_mon_trn_c trn);
   
   bit  sampled_trn = 0;
   
   trn = uvma_${name}_mon_trn_c::type_id::create("trn");
   trn.direction = UVMA_${name_uppercase}_DIRECTION_${direction_rx_uppercase};
   
   do begin
      @(cntxt.vif.mon_${direction_rx}_cb);
      
      // TODO Sample trn from vif's ${direction_rx_normal_case}
      //      Ex: if (cntxt.vif.reset == 0) begin
      //             if (cntxt.vif.mon_${direction_rx}_cb.${direction_rx}_enable) begin
      //                sampled_trn   = 1;
      //                trn.abc       = cntxt.vif.mon_${direction_rx}_cb.${direction_rx}_abc;
      //                trn.xyz       = cntxt.vif.mon_${direction_rx}_cb.${direction_rx}_xyz;
      //                trn.timestamp = $realtime();
      //             end
      //          end
      
      // WARNING If no time is consumed by this loop, a zero-delay oscillation loop will occur and stall simulation
   end while (!sampled_trn);
   
endtask : sample_${direction_rx}_traffic


task uvma_${name}_mon_c::sample_${direction_tx}_traffic(ref uvma_${name}_mon_trn_c trn);
   
   bit  sampled_trn = 0;
   
   trn = uvma_${name}_mon_trn_c::type_id::create("trn");
   trn.direction = UVMA_${name_uppercase}_DIRECTION_${direction_tx_uppercase};
   
   do begin
      @(cntxt.vif.mon_${direction_tx}_cb);
      
      // TODO Sample trn from vif's ${direction_tx_normal_case}
      //      Ex: if (cntxt.vif.reset == 0) begin
      //             if (cntxt.vif.mon_${direction_tx}_cb.${direction_tx}_enable) begin
      //                sampled_trn   = 1;
      //                trn.abc       = cntxt.vif.mon_${direction_tx}_cb.${direction_tx}_abc;
      //                trn.xyz       = cntxt.vif.mon_${direction_tx}_cb.${direction_tx}_xyz;
      //                trn.timestamp = $realtime();
      //             end
      //          end
      
      // WARNING If no time is consumed by this loop, a zero-delay oscillation loop will occur and stall simulation
   end while (!sampled_trn);
   
endtask : sample_${direction_tx}_traffic


task uvma_${name}_mon_c::process_${direction_rx}_traffic(ref uvma_${name}_mon_trn_c trn);
   
   // TODO Implement uvma_${name}_mon_c::process_${direction_rx}_traffic()
   
endtask : process_${direction_rx}_traffic


task uvma_${name}_mon_c::process_${direction_tx}_traffic(ref uvma_${name}_mon_trn_c trn);
   
   // TODO Implement uvma_${name}_mon_c::process_${direction_tx}_traffic()
   
endtask : process_${direction_tx}_traffic


`pragma protect end


`endif // __UVMA_${name_uppercase}_MON_SV__
