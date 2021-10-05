// Copyright 2021 Datum Technology Corporation
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVML_SEQ_LIB_SV__
`define __UVML_SEQ_LIB_SV__


/**
 * TODO Describe uvml_seq_lib_c
 */
class uvml_seq_lib_c #(
   type REQ = uvm_sequence_item,
   type RSP = uvm_sequence_item
) extends uvm_sequence_library #(
   .REQ(REQ),
   .RSP(RSP)
);
   
   `uvm_object_utils          (uvml_seq_lib_c)
   `uvm_sequence_library_utils(uvml_seq_lib_c)
   
   
   /**
    * Initializes sequence library
    */
   extern function new(string name="uvml_seq_lib");
   
endclass : uvml_seq_lib_c


function uvml_seq_lib_c::new(string name="uvml_seq_lib");
   
   super.new(name);
   init_sequence_library();
   
   // TODO Add sequences to uvml_seq_lib_c
   //      Ex: add_sequence(uvml_abc_seq_c::get_type());
   
endfunction : new


`endif // __UVML_SEQ_LIB_SV__
