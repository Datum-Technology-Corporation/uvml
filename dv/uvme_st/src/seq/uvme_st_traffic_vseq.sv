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


`ifndef __UVME_ST_TRAFFIC_VSEQ_SV__
`define __UVME_ST_TRAFFIC_VSEQ_SV__


/**
 * TODO Describe uvme_st_traffic_vseq_c
 */
class uvme_st_traffic_vseq_c extends uvme_st_base_vseq_c;
   
   rand int unsigned  num_bursts      ; ///<
   rand int unsigned  min_gap         ; ///< 
   rand int unsigned  max_gap         ; ///< 
   rand int unsigned  min_burst_size  ; ///< 
   rand int unsigned  max_burst_size  ; ///< 
   rand int unsigned  min_payload_size; ///< 
   rand int unsigned  max_payload_size; ///< 
   
   
   `uvm_object_utils_begin(uvme_st_traffic_vseq_c)
      `uvm_field_int(num_bursts      , UVM_DEFAULT + UVM_DEC)
      `uvm_field_int(min_gap         , UVM_DEFAULT + UVM_DEC)
      `uvm_field_int(max_gap         , UVM_DEFAULT + UVM_DEC)
      `uvm_field_int(min_burst_size  , UVM_DEFAULT + UVM_DEC)
      `uvm_field_int(max_burst_size  , UVM_DEFAULT + UVM_DEC)
      `uvm_field_int(min_payload_size, UVM_DEFAULT + UVM_DEC)
      `uvm_field_int(max_payload_size, UVM_DEFAULT + UVM_DEC)
   `uvm_object_utils_end
   
   
   /**
    * Describe name_cons
    */
   constraint name_cons {
      num_bursts >  0;
      num_bursts < 10;
      min_gap >   0;
      max_gap <= 50;
      max_gap >= min_gap;
      min_burst_size > 0;
      max_burst_size <= 100;
      max_burst_size >= min_burst_size;
      min_payload_size > 0;
      max_payload_size <= 255;
      max_payload_size >= min_payload_size;
   }
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvme_st_traffic_vseq");
   
   /**
    * TODO Describe uvme_st_traffic_vseq_c::body()
    */
   extern virtual task body();
   
endclass : uvme_st_traffic_vseq_c


function uvme_st_traffic_vseq_c::new(string name="uvme_st_traffic_vseq");
   
   super.new(name);
   
endfunction : new


task uvme_st_traffic_vseq_c::body();
   
   int unsigned         current_gap;
   uvma_st_burst_seq_c  seq;
   
   for (int unsigned ii=0; ii<num_bursts; ii++) begin
      `uvm_create_on(seq, p_sequencer.tx_sequencer)
      `uvm_info("TRAFFIC_VSEQ", $sformatf("Starting burst %0d of %0d:\n%s", ii+1, num_bursts, seq.sprint()), UVM_LOW)
      `uvm_rand_send_with(seq, {
         seq.size >= min_burst_size;
         seq.size <= max_burst_size;
         seq.min_payload_size == local::min_payload_size;
         seq.max_payload_size == local::max_payload_size;
      })
      current_gap = $urandom_range(min_gap, max_gap);
      `uvm_info("TRAFFIC_VSEQ", $sformatf("Finished burst %0d of %0d:\n%s", ii+1, num_bursts, seq.sprint()), UVM_LOW)
      if (ii > (num_bursts-1)) begin
         `uvm_info("TRAFFIC_VSEQ", $sformatf("Waiting %0dns before the next burst", current_gap), UVM_LOW)
         #(current_gap*1ns);
      end
   end
   
endtask : body


`endif // __UVME_ST_TRAFFIC_VSEQ_SV__
