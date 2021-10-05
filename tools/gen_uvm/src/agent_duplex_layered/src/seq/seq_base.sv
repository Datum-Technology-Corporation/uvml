// Copyright ${year} ${name_of_copyright_owner}
// 
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.


`ifndef __UVMA_${name_uppercase}_SEQ_BASE_SV__
`define __UVMA_${name_uppercase}_SEQ_BASE_SV__


/**
 * Abstract object from which all other ${name_normal_case} agent sequences must extend.
 * Subclasses must be run on ${name_normal_case} sequencer (uvma_${name}_sqr_c) instance.
 */
class uvma_${name}_seq_base_c extends uvm_sequence#(
   .REQ(uvma_${name}_seq_item_c),
   .RSP(uvma_${name}_seq_item_c)
);
   
   `uvm_object_utils(uvma_${name}_seq_base_c)
   `uvm_declare_p_sequencer(uvma_${name}_sqr_c)
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvma_${name}_seq_base");
   
endclass : uvma_${name}_seq_base_c


`pragma protect begin


function uvma_${name}_seq_base_c::new(string name="uvma_${name}_seq_base");
   
   super.new(name);
   
endfunction : new


`pragma protect end


`endif // __UVMA_${name_uppercase}_SEQ_BASE_SV__
