// Copyright ${year} ${name_of_copyright_owner}
// 
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.


`ifndef __UVMA_${name_uppercase}_SEQ_ITEM_SV__
`define __UVMA_${name_uppercase}_SEQ_ITEM_SV__


/**
 * Object created by ${name_normal_case} agent sequences extending uvma_${name}_seq_base_c.
 */
class uvma_${name}_seq_item_c extends uvml_trn_seq_item_c;
   
   // TODO Add uvma_${name}_seq_item_c fields
   //      Ex: rand bit [7:0]  abc;
   
   
   `uvm_object_utils_begin(uvma_${name}_seq_item_c)
      // TODO Add uvma_${name}_seq_item_c UVM field utils
      //      Ex: `uvm_field_int(abc, UVM_DEFAULT)
   `uvm_object_utils_end
   
   
   // TODO Add uvma_${name}_seq_item_c constraints
   //      Ex: constraint default_cons {
   //             abc inside {0,2,4,8,16,32};
   //          }
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvma_${name}_seq_item");
   
endclass : uvma_${name}_seq_item_c


`pragma protect begin


function uvma_${name}_seq_item_c::new(string name="uvma_${name}_seq_item");
   
   super.new(name);
   
endfunction : new


`pragma protect end


`endif // __UVMA_${name_uppercase}_SEQ_ITEM_SV__
