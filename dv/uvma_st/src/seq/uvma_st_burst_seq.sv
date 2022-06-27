// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_ST_BURST_SEQ_SV__
`define __UVMA_ST_BURST_SEQ_SV__


/**
 * TODO Describe uvma_st_burst_seq_c
 */
class uvma_st_burst_seq_c extends uvma_st_base_seq_c;
   
   // Fields
   rand int unsigned  size            ; ///< 
   rand int unsigned  min_payload_size; ///< 
   rand int unsigned  max_payload_size; ///< 
   
   
   `uvm_object_utils_begin(uvma_st_burst_seq_c)
      `uvm_field_int(size            , UVM_DEFAULT + UVM_DEC)
      `uvm_field_int(min_payload_size, UVM_DEFAULT + UVM_DEC)
      `uvm_field_int(max_payload_size, UVM_DEFAULT + UVM_DEC)
   `uvm_object_utils_end
   
   
   /**
    * Describe limits_cons
    */
   constraint limits_cons {
      size >    0;
      size <= 100;
      min_payload_size > 0;
      max_payload_size >= min_payload_size;
      max_payload_size <= 255;
   }
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvma_st_burst_seq");
   
   /**
    * TODO Describe uvma_st_burst_seq_c::body()
    */
   extern virtual task body();
   
endclass : uvma_st_burst_seq_c


function uvma_st_burst_seq_c::new(string name="uvma_st_burst_seq");
   
   super.new(name);
   
endfunction : new


task uvma_st_burst_seq_c::body();
   
   uvma_st_seq_item_c  req;
   
   super.body();
   
   for (int unsigned ii=0; ii<size; ii++) begin
      `uvm_create(req)
      `uvm_info("BURST_SEQ", $sformatf("Starting item %0d of %0d:\n%s", ii+1, size, req.sprint()), UVM_MEDIUM)
      `uvm_do_with(req, {
         req.payload.size inside {[min_payload_size:max_payload_size]};
      })
   end
   
endtask : body


`endif // __UVMA_ST_BURST_SEQ_SV__
