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


`ifndef __UVMA_ST_MON_TRN_SV__
`define __UVMA_ST_MON_TRN_SV__


/**
 * Object rebuilt from the Moore.io UVM Extension Library Self-Test Monitor (uvma_st_mon_c).  Analog of
 * uvma_st_seq_item_c.
 */
class uvma_st_mon_trn_c extends uvml_mon_trn_c;
   
   // Data
   int unsigned  payload_size;
   logic [7:0]   payload[$];
   
   
   `uvm_object_utils_begin(uvma_st_mon_trn_c)
      `uvm_field_int      (payload_size, UVM_DEFAULT + UVM_DEC + UVM_NOPACK)
      `uvm_field_queue_int(payload     , UVM_DEFAULT                       )
   `uvm_object_utils_end
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvma_st_mon_trn");
   
endclass : uvma_st_mon_trn_c


function uvma_st_mon_trn_c::new(string name="uvma_st_mon_trn");
   
   super.new(name);
   
endfunction : new


`endif // __UVMA_ST_MON_TRN_SV__
