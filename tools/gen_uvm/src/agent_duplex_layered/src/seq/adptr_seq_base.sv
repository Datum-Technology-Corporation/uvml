// Copyright ${year} ${name_of_copyright_owner}
// 
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.


`ifndef __UVMA_${name_uppercase}_ADPTR_SEQ_BASE_SV__
`define __UVMA_${name_uppercase}_ADPTR_SEQ_BASE_SV__


/**
 * Abstract object from which all other ${name_normal_case} adapter sequences must extend.
 * Converts layer (logical) data into physical data that can be used to drive a virtual interface (vif).
 * Subclasses must be run on ${name_normal_case} Sequencer (T_SQR) instance.
 */
class uvma_${name}_adptr_seq_base_c#(
   type T_IN  = uvm_sequence_item,
   type T_OUT = uvm_sequence_item,
   type T_SQR = uvm_sequencer
) extends uvm_sequence#(
   .REQ(T_OUT),
   .RSP(T_OUT)
);
   
   // To be used by subclass
   T_IN   item_in;
   T_OUT  item_out;
   
   
   `uvm_object_param_utils(uvma_${name}_adptr_seq_base_c#(T_IN, T_OUT, T_SQR))
   `uvm_declare_p_sequencer(T_SQR)
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvma_${name}_adptr_seq_base");
   
   /**
    * Returns sequence item from previous (above) layer.
    * Must be used by subclass rather than using p_sequencer directly.
    */
   extern task get_next_item(output T_IN item, input bit blocking=1);
   
   /**
    * Indicates to the sequencer of the previous (above) layer that item has been consumed.
    * Must be used by subclass rather than using p_sequencer directly.
    */
   extern task item_done(ref T_IN item=null);
   
endclass : uvma_${name}_adptr_seq_base_c


`pragma protect begin


function uvma_${name}_adptr_seq_base_c::new(string name="uvma_${name}_adptr_seq_base");
   
   super.new(name);
   
endfunction : new


task uvma_${name}_adptr_seq_base_c::get_next_item(output T_IN item, input bit blocking=1);
   
   if (blocking) begin
      p_sequencer.upstrm_sqr.get_next_item(item);
      p_sequencer.in_ap.write             (item);
   end
   else begin
      seq_item_port.try_next_item(item);
   end
   
endtask : get_next_item


task uvma_${name}_adptr_seq_base_c::item_done(ref T_IN item=null);
   
   p_sequencer.upstrm_sqr.item_done(item);
   
endtask : item_done


`pragma protect end


`endif // __UVMA_${name_uppercase}_ADPTR_SEQ_BASE_SV__
