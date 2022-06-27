// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVML_SEQ_SV__
`define __UVML_SEQ_SV__


/**
 * TODO Describe uvml_seq_c
 */
class uvml_seq_c #(
   type REQ = uvm_sequence_item,
   type RSP = uvm_sequence_item
) extends uvm_sequence #(
   .REQ(REQ),
   .RSP(RSP)
);
   
   // Fields
   
   
   `uvm_object_utils_begin(uvml_seq_c)
      
   `uvm_object_utils_end
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvml_seq");
   
   /**
    * TODO Describe uvml_seq_c::body()
    */
   extern virtual task body();
   
endclass : uvml_seq_c


function uvml_seq_c::new(string name="uvml_seq");
   
   super.new(name);
   
endfunction : new


task uvml_seq_c::body();
   
   // TODO Implement uvml_seq_c::body()
   
endtask : body


`endif // __UVML_SEQ_SV__
