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


`ifndef __UVMA_ST_SEQ_ITEM_SV__
`define __UVMA_ST_SEQ_ITEM_SV__


/**
 * Object created by Extension Library Self-Test agent sequences extending uvma_st_seq_base_c.
 */
class uvma_st_seq_item_c extends uvml_seq_item_c;
   
   // Fields
   rand bit [7:0]  payload[];
   
   
   `uvm_object_utils_begin(uvma_st_seq_item_c)
      `uvm_field_array_int(payload, UVM_DEFAULT)
   `uvm_object_utils_end
   
   
   constraint limits_cons {
      payload.size() inside {[1:255]};
   }
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvma_st_seq_item");
   
   /**
    * TODO Describe uvma_st_seq_item_c::get_metadata()
    */
   extern virtual function uvml_metadata_t get_metadata();
   
endclass : uvma_st_seq_item_c


function uvma_st_seq_item_c::new(string name="uvma_st_seq_item");
   
   super.new(name);
   
endfunction : new


function uvml_metadata_t uvma_st_seq_item_c::get_metadata();
   
   string           payload_str;
   uvml_metadata_t  metadata   ;
   
   payload_str = "";
   foreach (payload[ii]) begin
      payload_str = {"_", $sformatf("%02h", payload[ii]), payload_str};
   end
   
   metadata["payload"] = '{
      index     : 0,
      value     : payload_str,
      col_name  : "payload",
      col_width :  32,
      col_align : UVML_COL_ALIGN_RIGHT,
      data_type : UVML_FIELD_ARRAY_INT
   };
   
   return metadata;
   
endfunction : get_metadata


`endif // __UVMA_ST_SEQ_ITEM_SV__
