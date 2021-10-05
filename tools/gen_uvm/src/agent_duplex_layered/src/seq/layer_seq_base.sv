// Copyright ${year} ${name_of_copyright_owner}
// 
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.


`ifndef __UVMA_${name_uppercase}_LAYER_SEQ_BASE_SV__
`define __UVMA_${name_uppercase}_LAYER_SEQ_BASE_SV__


/**
 * 
 */
class uvma_${name}_layer_seq_base_c#(
   type T_IN  = uvm_sequence_item,
   type T_OUT = uvm_sequence_item,
   type T_SQR = uvm_sequencer
) extends uvm_sequence#(
   .REQ(T_OUT),
   .RSP(T_OUT)
);
   
   T_IN   trn_in;
   T_OUT  trn_out;
   
   
   `uvm_object_param_utils(uvma_${name}_layer_seq_base_c#(T_IN, T_OUT, T_SQR))
   `uvm_declare_p_sequencer(T_SQR)
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvma_${name}_sas_seq_base");
   
endclass : uvma_${name}_layer_seq_base_c


`pragma protect begin


function uvma_${name}_layer_seq_base_c::new(string name="uvma_${name}_sas_seq_base");
   
   super.new(name);
   
endfunction : new


`pragma protect end


`endif // __UVMA_${name_uppercase}_LAYER_SEQ_BASE_SV__
