// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMT_ST_VECTOR_FILE_TEST_SV__
`define __UVMT_ST_VECTOR_FILE_TEST_SV__


class vector_c extends uvm_object;

   bit [63:00]  raw_data   ;
   int          decimal    ;
   bit [07:00]  binary_data;

   `uvm_object_utils_begin(vector_c)
      `uvm_field_int(raw_data   , UVM_DEFAULT + UVM_HEX)
      `uvm_field_int(decimal    , UVM_DEFAULT + UVM_HEX)
      `uvm_field_int(binary_data, UVM_DEFAULT + UVM_HEX)
   `uvm_object_utils_end

   function new(string name="vector");
      super.new(name);
   endfunction : new

endclass : vector_c


/**
 * TODO Describe uvmt_st_vector_file_test_c
 */
class uvmt_st_vector_file_test_c extends uvmt_st_base_test_c;

   uvml_vector_file_c  vector_file; ///<


   `uvm_component_utils(uvmt_st_vector_file_test_c)


   /**
    * Default constructor.
    */
   extern function new(string name="uvmt_st_vector_file_test", uvm_component parent=null);

   /**
    * Reads back file and checks contents.
    */
   extern virtual task main_phase(uvm_phase phase);

endclass : uvmt_st_vector_file_test_c


function uvmt_st_vector_file_test_c::new(string name="uvmt_st_vector_file_test", uvm_component parent=null);

   super.new(name, parent);

endfunction : new


task uvmt_st_vector_file_test_c::main_phase(uvm_phase phase);

   uvml_bit_array_t   bits ;
   uvml_byte_array_t  bytes;
   string    readback = "";
   vector_c  vector_trn_act = vector_c::type_id::create("vector_trn_act");
   vector_c  vector_trn_exp = vector_c::type_id::create("vector_trn_exp");

   super.main_phase(phase);
   phase.raise_objection(this);

   vector_trn_exp.raw_data    = 64'hfedc_ba98_7654_3210;
   vector_trn_exp.decimal     = 32'haa55_aa55;
   vector_trn_exp.binary_data =  8'he4;

   // BITS
   vector_file = uvml_vector_file_c::type_id::create("vector_file_bits");
   vector_file.set_base_dir(UVML_FILE_BASE_DIR_TESTS);
   vector_file.open(UVM_READ, "files/vector.txt");
   vector_file.get_next_lines_bits(3, UVM_HEX, bits);
   vector_trn_act.unpack(bits);
   vector_file.close();
   if (vector_trn_exp.compare(vector_trn_act)) begin
      `uvm_info("TEST", $sformatf("BYTES: Actual and expected vectors match:\n%s", vector_trn_exp.sprint()), UVM_NONE)
   end
   else begin
      `uvm_error("TEST", $sformatf("BYTES: Actual and expected vectors do not match:\nExpected:\n%s\nActual:\n%s", vector_trn_exp.sprint(), vector_trn_act.sprint()))
   end

   // BYTES
   vector_file = uvml_vector_file_c::type_id::create("vector_file_bytes");
   vector_file.set_base_dir(UVML_FILE_BASE_DIR_TESTS);
   vector_file.open(UVM_READ, "files/vector.txt");
   vector_file.get_next_lines_bytes(3, UVM_HEX, bytes);
   `uvm_info("TEST", $sformatf("bytes.size() = %0d", bytes.size()), UVM_NONE)
   foreach (bytes[ii]) begin
      `uvm_info("TEST", $sformatf("bytes[%0d]=%h", ii, bytes[ii]), UVM_NONE)
   end
   vector_trn_act.unpack_bytes(bytes);
   vector_file.close();
   if (vector_trn_exp.compare(vector_trn_act)) begin
      `uvm_info("TEST", $sformatf("BYTES: Actual and expected vectors match:\n%s", vector_trn_exp.sprint()), UVM_NONE)
   end
   else begin
      `uvm_error("TEST", $sformatf("BYTES: Actual and expected vectors do not match:\nExpected:\n%s\nActual:\n%s", vector_trn_exp.sprint(), vector_trn_act.sprint()))
   end

   phase.drop_objection(this);

endtask : main_phase


`endif // __UVMT_ST_VECTOR_FILE_TEST_SV__
