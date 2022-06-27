// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVML_SEQ_LIB_SV__
`define __UVML_SEQ_LIB_SV__


/**
 * TODO Describe uvml_seq_lib_c
 */
class uvml_seq_lib_c #(
   type REQ = uvm_sequence_item,
   type RSP = uvm_sequence_item
) extends uvm_sequence_library #(
   .REQ(REQ),
   .RSP(RSP)
);
   
   `uvm_object_utils          (uvml_seq_lib_c)
   `uvm_sequence_library_utils(uvml_seq_lib_c)
   
   
   /**
    * Initializes sequence library
    */
   extern function new(string name="uvml_seq_lib");
   
endclass : uvml_seq_lib_c


function uvml_seq_lib_c::new(string name="uvml_seq_lib");
   
   super.new(name);
   init_sequence_library();
   
   // TODO Add sequences to uvml_seq_lib_c
   //      Ex: add_sequence(uvml_abc_seq_c::get_type());
   
endfunction : new


`endif // __UVML_SEQ_LIB_SV__
