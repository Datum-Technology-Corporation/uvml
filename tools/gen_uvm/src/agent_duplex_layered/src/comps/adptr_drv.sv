// Copyright ${year} ${name_of_copyright_owner}
// 
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.


`ifndef __UVMA_${name_uppercase}_ADPTR_${layer_name_uppercase}_DRV_SV__
`define __UVMA_${name_uppercase}_ADPTR_${layer_name_uppercase}_DRV_SV__


/**
 * Component driving a ${name_normal_case} ${layer_name_normal_case} virtual interface
 * (uvma_${name}_${layer_name}_if) in both directions.
 */
class uvma_${name}_adptr_drv_${layer_name}_c extends uvma_${name}_adptr_drv_base_c#(
   .T_REQ(uvma_${name}_adptr_seq_item_${layer_name}_c),
   .T_RSP(uvma_${name}_adptr_seq_item_${layer_name}_c)
);
   
   `uvm_component_utils(uvma_${name}_adptr_drv_${layer_name}_c)
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvma_${name}_adptr_drv_${layer_name}", uvm_component parent=null);
   
   /**
    * TODO Describe uvma_${name}_adptr_drv_${layer_name}_c::drv_${direction_rx}_pre_reset()
    */
   extern virtual task drv_${direction_rx}_pre_reset();
   
   /**
    * TODO Describe uvma_${name}_adptr_drv_${layer_name}_c::drv_${direction_tx}_pre_reset()
    */
   extern virtual task drv_${direction_tx}_pre_reset();
   
   /**
    * TODO Describe uvma_${name}_adptr_drv_${layer_name}_c::drv_${direction_rx}_in_reset()
    */
   extern virtual task drv_${direction_rx}_in_reset();
   
   /**
    * TODO Describe uvma_${name}_adptr_drv_${layer_name}_c::drv_${direction_tx}_in_reset()
    */
   extern virtual task drv_${direction_tx}_in_reset();
   
   /**
    * TODO Describe uvma_${name}_adptr_drv_${layer_name}_c::drv_${direction_rx}_post_reset()
    */
   extern virtual task drv_${direction_rx}_post_reset();
   
   /**
    * TODO Describe uvma_${name}_adptr_drv_${layer_name}_c::drv_${direction_tx}_post_reset()
    */
   extern virtual task drv_${direction_tx}_post_reset();
   
   /**
    * TODO Describe uvma_${name}_adptr_drv_${layer_name}_c::drv_${direction_tx}_req()
    */
   extern virtual task drv_${direction_tx}_req(ref uvma_${name}_adptr_seq_item_${layer_name}_c req);
   
   /**
    * TODO Describe uvma_${name}_adptr_drv_${layer_name}_c::drv_${direction_tx}_idle()
    */
   extern virtual task drv_${direction_tx}_idle();
   
endclass : uvma_${name}_adptr_drv_${layer_name}_c


`pragma protect begin


function uvma_${name}_adptr_drv_${layer_name}_c::new(string name="uvma_${name}_adptr_drv_${layer_name}", uvm_component parent=null);
   
   super.new(name, parent);
   
endfunction : new


task uvma_${name}_adptr_drv_${layer_name}_c::drv_${direction_rx}_pre_reset();
   
   // TODO Implement uvma_${name}_adptr_drv_${layer_name}_c::drv_${direction_rx}_pre_reset()
   //      Ex: @(cntxt.${layer_name}_vif.drv_${direction_rx}_cb);
   
   // WARNING If no time is consumed by this task, a zero-delay oscillation loop will occur and stall simulation
   
endtask : drv_${direction_rx}_pre_reset


task uvma_${name}_adptr_drv_${layer_name}_c::drv_${direction_tx}_pre_reset();
   
   // TODO Implement uvma_${name}_adptr_drv_${layer_name}_c::drv_${direction_tx}_pre_reset()
   //      Ex: @(cntxt.${layer_name}_vif.drv_${direction_tx}_cb);
   
   // WARNING If no time is consumed by this task, a zero-delay oscillation loop will occur and stall simulation
   
endtask : drv_${direction_tx}_pre_reset


task uvma_${name}_adptr_drv_${layer_name}_c::drv_${direction_rx}_in_reset();
   
   // TODO Implement uvma_${name}_adptr_drv_${layer_name}_c::drv_${direction_rx}_in_reset()
   //      Ex: @(cntxt.${layer_name}_vif.drv_${direction_rx}_cb);
   
   // WARNING If no time is consumed by this task, a zero-delay oscillation loop will occur and stall simulation
   
endtask : drv_${direction_rx}_in_reset


task uvma_${name}_adptr_drv_${layer_name}_c::drv_${direction_tx}_in_reset();
   
   // TODO Implement uvma_${name}_adptr_drv_${layer_name}_c::drv_${direction_tx}_in_reset()
   //      Ex: @(cntxt.${layer_name}_vif.drv_${direction_tx}_cb);
   
   // WARNING If no time is consumed by this task, a zero-delay oscillation loop will occur and stall simulation
   
endtask : drv_${direction_tx}_in_reset


task uvma_${name}_adptr_drv_${layer_name}_c::drv_${direction_rx}_post_reset();
   
   // TODO Implement uvma_${name}_adptr_drv_${layer_name}_c::drv_${direction_rx}_post_reset()
   //      Ex: @(cntxt.${layer_name}_vif.drv_${direction_rx}_cb);
   //          cntxt.${layer_name}_vif.drv_${direction_rx}_cb.${direction_rx}_ready <= 1;
   
   // WARNING If no time is consumed by this task, a zero-delay oscillation loop will occur and stall simulation
   
endtask : drv_${direction_rx}_post_reset


task uvma_${name}_adptr_drv_${layer_name}_c::drv_${direction_tx}_req(ref uvma_${name}_adptr_seq_item_${layer_name}_c req);
   
   `uvm_info("${name_uppercase}_DRV", $sformatf("Got new req from sequencer:\n%s", req.sprint()), UVM_HIGH)
   
   // TODO Implement uvma_${name}_adptr_drv_${layer_name}_c::drv_${direction_tx}_req()
   //      Ex: @(cntxt.${layer_name}_vif.drv_${direction_tx}_cb);
   //          if (cntxt.${layer_name}_vif.drv_${direction_tx}_cb.${direction_tx}_ready) begin
   //             cntxt.${layer_name}_vif.drv_${direction_tx}_cb.${direction_tx}_abc <= req.abc;
   //             cntxt.${layer_name}_vif.drv_${direction_tx}_cb.${direction_tx}_xyz <= req.xyz;
   //          end
   
   // WARNING If no time is consumed by this task, a zero-delay oscillation loop will occur and stall simulation
   
endtask : drv_${direction_tx}_req


task uvma_${name}_adptr_drv_${layer_name}_c::drv_${direction_tx}_idle();
   
   // TODO Implement uvma_${name}_adptr_drv_${layer_name}_c::drv_${direction_tx}_req()
   //      Ex: @(cntxt.${layer_name}_vif.drv_${direction_tx}_cb);
   
   // WARNING If no time is consumed by this task, a zero-delay oscillation loop will occur and stall simulation
   
endtask : drv_${direction_tx}_idle


`pragma protect end


`endif // __UVMA_${name_uppercase}_ADPTR_${layer_name_uppercase}_DRV_SV__
