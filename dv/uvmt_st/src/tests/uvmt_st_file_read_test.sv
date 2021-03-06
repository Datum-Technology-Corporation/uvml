// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMT_ST_FILE_READ_TEST_SV__
`define __UVMT_ST_FILE_READ_TEST_SV__


/**
 * TODO Describe uvmt_st_file_read_test_c
 */
class uvmt_st_file_read_test_c extends uvmt_st_base_test_c;
   
   uvml_file_c  file; ///< 
   
   
   `uvm_component_utils(uvmt_st_file_read_test_c)
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvmt_st_file_read_test", uvm_component parent=null);
   
   /**
    * Reads back file and checks contents.
    */
   extern virtual task main_phase(uvm_phase phase);
   
endclass : uvmt_st_file_read_test_c


function uvmt_st_file_read_test_c::new(string name="uvmt_st_file_read_test", uvm_component parent=null);
   
   super.new(name, parent);
   
endfunction : new


task uvmt_st_file_read_test_c::main_phase(uvm_phase phase);
   
   string  readback = "";
   
   super.main_phase(phase);
   
   phase.raise_objection(this);
   
   file = uvml_file_c::type_id::create("file");
   file.set_base_dir(UVML_FILE_BASE_DIR_TESTS);
   file.open(UVM_READ, "files/read_test.txt");
   readback = file.read_line();
   file.close();
   
   if (readback != "abcdef") begin
      `uvm_error("TEST", $sformatf("File contents (%s) do not match expectations (abcdef)", readback))
   end
   else begin
      `uvm_info("TEST", "File contents match expectations", UVM_NONE)
   end
   
   phase.drop_objection (this);
   
endtask : main_phase


`endif // __UVMT_ST_FILE_READ_TEST_SV__
