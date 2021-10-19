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


`ifndef __UVML_SEQ_ITEM_SV__
`define __UVML_SEQ_ITEM_SV__


/**
 * TODO Describe uvml_seq_item_c
 */
class uvml_seq_item_c extends uvm_sequence_item;
   
   int unsigned  __uid      ; ///< 
   bit           __may_drop ; ///< 
   bit           __has_error; ///< 
   
   static int unsigned  __last_uid = 0;///< 
   
  `uvm_object_utils_begin(uvml_mon_trn_c)
      `uvm_field_int(__may_drop , UVM_DEFAULT + UVM_NOPACK + UVM_NOCOMPARE)
      `uvm_field_int(__has_error, UVM_DEFAULT + UVM_NOPACK + UVM_NOCOMPARE)
  `uvm_object_utils_end
  
  
  /**
   * Default constructor
   */
  extern function new(string name="uvml_seq_item");
   
   /**
    * TODO Describe uvml_seq_item_c::get_uid()
    */
   extern function int unsigned get_uid();
   
   /**
    * TODO Describe uvml_seq_item_c::get_may_drop()
    */
   extern function bit get_may_drop();
   
   /**
    * TODO Describe uvml_seq_item_c::set_may_drop()
    */
   extern function void set_may_drop(bit val);
   
   /**
    * TODO Describe uvml_seq_item_c::has_error()
    */
   extern function bit has_error();
   
   /**
    * TODO Describe uvml_seq_item_c::set_error()
    */
   extern function void set_error(bit val);
   
   /**
    * TODO Describe uvml_seq_item_c::get_metadata()
    */
   extern virtual function uvml_metadata_t get_metadata();
  
endclass : uvml_seq_item_c


function uvml_seq_item_c::new(string name="uvml_seq_item");
   
   super.new(name);
   __uid       = __last_uid++;
   __may_drop  = 0;
   __has_error = 0;
  
endfunction : new


function int unsigned uvml_seq_item_c::get_uid();
   
   return __uid;
   
endfunction : get_uid


function bit uvml_seq_item_c::get_may_drop();
   
   return __may_drop;
   
endfunction : get_may_drop


function void uvml_seq_item_c::set_may_drop(bit val);
   
   __may_drop = val;
   
endfunction : set_may_drop


function bit uvml_seq_item_c::has_error();
   
   return __has_error;
   
endfunction : has_error


function void uvml_seq_item_c::set_error(bit val);
   
   __has_error = val;
   
endfunction : set_error


function uvml_metadata_t uvml_seq_item_c::get_metadata();
   
   uvml_metadata_t  empty_set;
   return empty_set;
   
endfunction : get_metadata


`endif // __UVML_SEQ_ITEM_SV__
