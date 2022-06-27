// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
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
   
   /**
    * TODO Describe uvma_st_mon_trn_c::get_metadata()
    */
   extern virtual function uvml_metadata_t get_metadata();
   
endclass : uvma_st_mon_trn_c


function uvma_st_mon_trn_c::new(string name="uvma_st_mon_trn");
   
   super.new(name);
   
endfunction : new


function uvml_metadata_t uvma_st_mon_trn_c::get_metadata();
   
   string           payload_str;
   uvml_metadata_t  metadata   ;
   
   payload_str = "";
   foreach (payload[ii]) begin
      payload_str = {"_", $sformatf("%02h", payload[ii]), payload_str};
   end
   
   metadata[0] = '{
      index     : 0,
      value     : payload_str,
      col_name  : "size",
      col_width :  4,
      col_align : UVML_TEXT_ALIGN_RIGHT,
      data_type : UVML_FIELD_INT
   };
   
   metadata[1] = '{
      index     : 1,
      value     : payload_str,
      col_name  : "data",
      col_width :  32,
      col_align : UVML_TEXT_ALIGN_RIGHT,
      data_type : UVML_FIELD_QUEUE_INT
   };
   
   return metadata;
   
endfunction : get_metadata


`endif // __UVMA_ST_MON_TRN_SV__
