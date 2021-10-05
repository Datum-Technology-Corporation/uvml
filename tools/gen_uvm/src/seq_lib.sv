// Copyright ${year} ${name_of_copyright_owner}
// 
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.


`ifndef __${pkg_name_uppercase}_${name_uppercase}_SEQ_LIB_SV__
`define __${pkg_name_uppercase}_${name_uppercase}_SEQ_LIB_SV__


/**
 * TODO Describe ${pkg_name}_${name}_seq_lib_c
 */
class ${pkg_name}_${name}_seq_lib_c extends uvm_sequence_library#(
   .REQ(${pkg_name}_${name}_seq_item_c),
   .RSP(${pkg_name}_${name}_seq_item_c)
);
   
   `uvm_object_utils          (${pkg_name}_${name}_seq_lib_c)
   `uvm_sequence_library_utils(${pkg_name}_${name}_seq_lib_c)
   
   
   /**
    * Initializes sequence library
    */
   extern function new(string name="${pkg_name}_${name}_seq_lib");
   
endclass : ${pkg_name}_${name}_seq_lib_c


function ${pkg_name}_${name}_seq_lib_c::new(string name="${pkg_name}_${name}_seq_lib");
   
   super.new(name);
   init_sequence_library();
   
   // TODO Add sequences to ${pkg_name}_${name}_seq_lib_c
   //      Ex: add_sequence(${pkg_name}_${name}_abc_seq_c::get_type());
   
endfunction : new


`endif // __${pkg_name_uppercase}_${name_uppercase}_SEQ_LIB_SV__
