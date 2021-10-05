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


`ifndef __UVMT_ST_FILE_WRITE_TEST_SV__
`define __UVMT_ST_FILE_WRITE_TEST_SV__


/**
 * TODO Describe uvmt_st_file_write_test_c
 */
class uvmt_st_file_write_test_c extends uvmt_st_base_test_c;
   
   uvml_file_c  file; ///< 
   
   
   `uvm_component_utils(uvmt_st_file_write_test_c)
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvmt_st_file_write_test", uvm_component parent=null);
   
   /**
    * Creates object(s).
    */
   extern virtual function void create_objects();
   
   /**
    * Reads back file and checks contents.
    */
   extern virtual task main_phase(uvm_phase phase);
   
endclass : uvmt_st_file_write_test_c


function uvmt_st_file_write_test_c::new(string name="uvmt_st_file_write_test", uvm_component parent=null);
   
   super.new(name, parent);
   
endfunction : new


function void uvmt_st_file_write_test_c::create_objects();
   
   file = uvml_file_c::type_id::create("file.txt");
   
endfunction : create_objects


task uvmt_st_file_write_test_c::main_phase(uvm_phase phase);
   
   string  readback = "";
   
   super.main_phase(phase);
   
   phase.raise_objection(this);
   file.open(UVML_FILE_ACCESS_WRITE);
   file.write_line("abc");
   file.write("def");
   file.close();
   file.open(UVML_FILE_ACCESS_READ);
   readback = file.read_line();
   readback = {readback, file.read_line()};
   if (readback != "abcdef") begin
      `uvm_error("TEST", $sformatf("File contents (%s) do not match expectations (abcdef)", readback))
   end
   else begin
      `uvm_info("TEST", "File contents match expectations", UVM_NONE)
   end
   phase.drop_objection(this);
   
endtask : main_phase


`endif // __UVMT_ST_FILE_WRITE_TEST_SV__
