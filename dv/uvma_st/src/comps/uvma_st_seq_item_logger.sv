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


`ifndef __UVMA_ST_SEQ_ITEM_LOGGER_SV__
`define __UVMA_ST_SEQ_ITEM_LOGGER_SV__


/**
 * Component writing Extension Library Self-Test sequence items debug data to disk as plain text.
 */
class uvma_st_seq_item_logger_c extends uvm_subscriber#(.T(uvma_st_seq_item_c));
   
   uvml_file_c  file; ///< 
   
   `uvm_component_utils(uvma_st_seq_item_logger_c)
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvma_st_seq_item_logger", uvm_component parent=null);
   
   /**
    * Writes log header to disk.
    */
   extern virtual function void end_of_elaboration_phase(uvm_phase phase);
   
   /**
    * Writes contents of t to disk.
    */
   extern virtual function void write(uvma_st_seq_item_c t);
   
endclass : uvma_st_seq_item_logger_c


function uvma_st_seq_item_logger_c::new(string name="uvma_st_seq_item_logger", uvm_component parent=null);
   
   super.new(name, parent);
   
endfunction : new


function void uvma_st_seq_item_logger_c::end_of_elaboration_phase(uvm_phase phase);
   
   file = uvml_file_c::type_id::create("file");
   file.set_base_dir(UVML_FILE_BASE_DIR_TEST_RESULTS);
   file.set_path({"/trn_log/", get_parent().get_full_name(), ".seq_item.log"});
   file.open(UVML_FILE_ACCESS_WRITE);
   file.write_line("-------------------");
   file.write_line("    TIME    | SIZE | DATA ");
   file.write_line("-------------------");
   
endfunction : end_of_elaboration_phase


function void uvma_st_seq_item_logger_c::write(uvma_st_seq_item_c t);
   
   // TODO Implement uvma_st_seq_item_logger_c::write()
   // Ex: fwrite($sformatf(" %t | %08h | %02b | %04d | %02h |", $realtime(), t.a, t.b, t.c, t.d));
   
endfunction : write


`endif // __UVMA_ST_SEQ_ITEM_LOGGER_SV__
