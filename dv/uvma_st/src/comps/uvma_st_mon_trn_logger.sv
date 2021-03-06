// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_ST_MON_TRN_LOGGER_SV__
`define __UVMA_ST_MON_TRN_LOGGER_SV__


/**
 * Component writing Extension Library Self-Test monitor transactions debug data to disk as plain text.
 */
class uvma_st_mon_trn_logger_c extends uvm_subscriber #(
   .T(uvma_st_mon_trn_c)
);
   
   uvml_file_c  file; ///< 
   
   
   `uvm_component_utils(uvma_st_mon_trn_logger_c)
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvma_st_mon_trn_logger", uvm_component parent=null);
   
   /**
    * Writes log header to disk
    */
   extern virtual function void end_of_elaboration_phase(uvm_phase phase);
   
   /**
    * Writes contents of t to disk
    */
   extern virtual function void write(uvma_st_mon_trn_c t);
   
endclass : uvma_st_mon_trn_logger_c


function uvma_st_mon_trn_logger_c::new(string name="uvma_st_mon_trn_logger", uvm_component parent=null);
   
   super.new(name, parent);
   
endfunction : new


function void uvma_st_mon_trn_logger_c::end_of_elaboration_phase(uvm_phase phase);
   
   file = uvml_file_c::type_id::create("file");
   file.set_base_dir(UVML_FILE_BASE_DIR_TEST_RESULTS);
   file.set_path({"/trn_log/", get_parent().get_full_name(), ".mon_trn.log"});
   file.open(UVM_WRITE);
   file.write_line("        TIME        | SIZE | DATA ");
   file.write_line("----------------------------");
   
endfunction : end_of_elaboration_phase


function void uvma_st_mon_trn_logger_c::write(uvma_st_mon_trn_c t);
   
   string payload_str = "";
   
   foreach (t.payload[ii]) begin
      payload_str = {"_", $sformatf("%02h", t.payload[ii]), payload_str};
   end
   file.write_line($sformatf(" %t |  %03d | %02s", t.get_timestamp_end(), t.payload_size, payload_str));
   
endfunction : write


`endif // __UVMA_ST_MON_TRN_LOGGER_SV__
