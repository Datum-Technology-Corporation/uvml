// Copyright ${year} ${name_of_copyright_owner}
// 
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.


`ifndef __UVMA_${name_uppercase}_ADPTR_MON_${layer_name_uppercase}_SV__
`define __UVMA_${name_uppercase}_ADPTR_MON_${layer_name_uppercase}_SV__


/**
 * Component monitoring the ${name_normal_case} ${layer_name_normal_case} virtual interface (uvma_${name}_${layer_name}_if).
 */
class uvma_${name}_adptr_mon_${layer_name}_c extends uvma_${name}_adptr_mon_base_c#(
   .T_TRN_IN (uvma_${name}_adptr_mon_trn_${layer_name}_c),
   .T_TRN_OUT(uvma_${name}_mon_trn_c)
);
   
   `uvm_component_utils(uvma_${name}_adptr_mon_${layer_name}_c)
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvma_${name}_adptr_mon_${layer_name}", uvm_component parent=null);
   
   /**
    * TODO Describe uvma_${name}_adptr_mon_${layer_name}_c::observe_reset()
    */
   extern virtual task observe_reset();
   
   /**
    * TODO Describe uvma_${name}_adptr_mon_${layer_name}_c::mon_${direction_rx}_pre_reset()
    */
   extern virtual task mon_${direction_rx}_pre_reset();
   
   /**
    * TODO Describe uvma_${name}_adptr_mon_${layer_name}_c::mon_${direction_tx}_pre_reset()
    */
   extern virtual task mon_${direction_tx}_pre_reset();
   
   /**
    * TODO Describe uvma_${name}_adptr_mon_${layer_name}_c::mon_${direction_rx}_in_reset()
    */
   extern virtual task mon_${direction_rx}_in_reset();
   
   /**
    * TODO Describe uvma_${name}_adptr_mon_${layer_name}_c::mon_${direction_tx}_in_reset()
    */
   extern virtual task mon_${direction_tx}_in_reset();
   
   /**
    * TODO Describe uvma_${name}_adptr_mon_${layer_name}_c::sample_${direction_rx}_traffic()
    */
   extern virtual task sample_${direction_rx}_traffic(ref uvma_${name}_adptr_mon_trn_${layer_name}_c trn);
   
   /**
    * TODO Describe uvma_${name}_adptr_mon_${layer_name}_c::sample_${direction_tx}_traffic()
    */
   extern virtual task sample_${direction_tx}_traffic(ref uvma_${name}_adptr_mon_trn_${layer_name}_c trn);
   
   /**
    * TODO Describe uvma_${name}_adptr_mon_${layer_name}_c::process_${direction_rx}_traffic
    */
   extern virtual task process_${direction_rx}_traffic(ref uvma_${name}_adptr_mon_trn_${layer_name}_c trn);
   
   /**
    * TODO Describe uvma_${name}_adptr_mon_${layer_name}_c::process_${direction_tx}_traffic
    */
   extern virtual task process_${direction_tx}_traffic(ref uvma_${name}_adptr_mon_trn_${layer_name}_c trn);
   
endclass : uvma_${name}_adptr_mon_${layer_name}_c


`pragma protect begin


function uvma_${name}_adptr_mon_${layer_name}_c::new(string name="uvma_${name}_adptr_mon_${layer_name}", uvm_component parent=null);
   
   super.new(name, parent);
   
endfunction : new


task uvma_${name}_adptr_mon_${layer_name}_c::observe_reset();
   
   // TODO Implement uvma_${name}_adptr_mon_${layer_name}_c::observe_reset()
   //      Ex: forever begin
   //             wait (cntxt.${layer_name}_vif.reset == 1);
   //             cntxt.reset_state = UVMA_${name_uppercase}_RESET_STATE_IN_RESET;
   //             wait (cntxt.${layer_name}_vif.reset == 0);
   //             cntxt.reset_state = UVMA_${name_uppercase}_RESET_STATE_POST_RESET;
   //          end
   
   // WARNING If no time is consumed by this task, a zero-delay oscillation loop will occur and stall simulation
   
endtask : observe_reset


task uvma_${name}_adptr_mon_${layer_name}_c::mon_${direction_rx}_pre_reset();
   
   // TODO Implement uvma_${name}_adptr_mon_${layer_name}_c::mon_${direction_rx}_pre_reset()
   //      Ex: @(cntxt.${layer_name}_vif.mon_${direction_rx}_cb);
   
   // WARNING If no time is consumed by this task, a zero-delay oscillation loop will occur and stall simulation
   
endtask : mon_${direction_rx}_pre_reset


task uvma_${name}_adptr_mon_${layer_name}_c::mon_${direction_tx}_pre_reset();
   
   // TODO Implement uvma_${name}_adptr_mon_${layer_name}_c::mon_${direction_tx}_pre_reset()
   //      Ex: @(cntxt.${layer_name}_vif.mon_${direction_tx}_cb);
   
   // WARNING If no time is consumed by this task, a zero-delay oscillation loop will occur and stall simulation
   
endtask : mon_${direction_tx}_pre_reset


task uvma_${name}_adptr_mon_${layer_name}_c::mon_${direction_rx}_in_reset();
   
   // TODO Implement uvma_${name}_adptr_mon_${layer_name}_c::mon_${direction_rx}_in_reset()
   //      Ex: @(cntxt.${layer_name}_vif.mon_${direction_rx}_cb);
   
   // WARNING If no time is consumed by this task, a zero-delay oscillation loop will occur and stall simulation
   
endtask : mon_${direction_rx}_in_reset


task uvma_${name}_adptr_mon_${layer_name}_c::mon_${direction_tx}_in_reset();
   
   // TODO Implement uvma_${name}_adptr_mon_${layer_name}_c::mon_${direction_tx}_in_reset()
   //      Ex: @(cntxt.${layer_name}_vif.mon_${direction_tx}_cb);
   
   // WARNING If no time is consumed by this task, a zero-delay oscillation loop will occur and stall simulation
   
endtask : mon_${direction_tx}_in_reset


task uvma_${name}_adptr_mon_${layer_name}_c::sample_${direction_rx}_traffic(ref uvma_${name}_adptr_mon_trn_${layer_name}_c trn);
   
   bit  sampled_trn = 0;
   
   trn = uvma_${name}_adptr_mon_trn_${layer_name}_c::type_id::create("trn");
   trn.direction = UVMA_${name_uppercase}_DIRECTION_${direction_rx_uppercase};
   
   do begin
      @(cntxt.${layer_name}_vif.mon_${direction_rx}_cb);
      
      // TODO Sample trn from vif's ${direction_rx_normal_case}
      //      Ex: if (cntxt.${layer_name}_vif.reset == 0) begin
      //             if (cntxt.${layer_name}_vif.mon_${direction_rx}_cb.${direction_rx}_enable) begin
      //                sampled_trn   = 1;
      //                trn.abc       = cntxt.${layer_name}_vif.mon_${direction_rx}_cb.${direction_rx}_abc;
      //                trn.xyz       = cntxt.${layer_name}_vif.mon_${direction_rx}_cb.${direction_rx}_xyz;
      //                trn.timestamp = $realtime();
      //             end
      //          end
      
      // WARNING If no time is consumed by this loop, a zero-delay oscillation loop will occur and stall simulation
   end while (!sampled_trn);
   
endtask : sample_${direction_rx}_traffic


task uvma_${name}_adptr_mon_${layer_name}_c::sample_${direction_tx}_traffic(ref uvma_${name}_adptr_mon_trn_${layer_name}_c trn);
   
   bit  sampled_trn = 0;
   
   trn = uvma_${name}_adptr_mon_trn_${layer_name}_c::type_id::create("trn");
   trn.direction = UVMA_${name_uppercase}_DIRECTION_${direction_tx_uppercase};
   
   do begin
      @(cntxt.${layer_name}_vif.mon_${direction_tx}_cb);
      
      // TODO Sample trn from vif's ${direction_tx_normal_case}
      //      Ex: if (cntxt.${layer_name}_vif.reset == 0) begin
      //             if (cntxt.${layer_name}_vif.mon_${direction_tx}_cb.${direction_tx}_enable) begin
      //                sampled_trn   = 1;
      //                trn.abc       = cntxt.${layer_name}_vif.mon_${direction_tx}_cb.${direction_tx}_abc;
      //                trn.xyz       = cntxt.${layer_name}_vif.mon_${direction_tx}_cb.${direction_tx}_xyz;
      //                trn.timestamp = $realtime();
      //             end
      //          end
      
      // WARNING If no time is consumed by this loop, a zero-delay oscillation loop will occur and stall simulation
   end while (!sampled_trn);
   
endtask : sample_${direction_tx}_traffic


task uvma_${name}_adptr_mon_${layer_name}_c::process_${direction_rx}_traffic(ref uvma_${name}_adptr_mon_trn_${layer_name}_c trn);
   
   // TODO Implement uvma_${name}_adptr_mon_${layer_name}_c::process_${direction_rx}_traffic()
   
endtask : process_${direction_rx}_traffic


task uvma_${name}_adptr_mon_${layer_name}_c::process_${direction_tx}_traffic(ref uvma_${name}_adptr_mon_trn_${layer_name}_c trn);
   
   // TODO Implement uvma_${name}_adptr_mon_${layer_name}_c::process_${direction_tx}_traffic()
   
endtask : process_${direction_tx}_traffic


`pragma protect end


`endif // __UVMA_${name_uppercase}_ADPTR_MON_${layer_name_uppercase}_SV__
