// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVML_VSEQ_SV__
`define __UVML_VSEQ_SV__


/**
 * TODO Describe uvml_vseq_c
 */
class uvml_vseq_c #(
   type REQ = uvm_sequence_item,
   type RSP = uvm_sequence_item
) extends uvm_sequence #(
   .REQ(REQ),
   .RSP(RSP)
);
   
   // Fields
   
   
   `uvm_object_utils_begin(uvml_vseq_c)
      
   `uvm_object_utils_end
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvml_vseq");
   
   /**
    * TODO Describe uvml_vseq_c::body()
    */
   extern virtual task body();
   
endclass : uvml_vseq_c


function uvml_vseq_c::new(string name="uvml_vseq");
   
   super.new(name);
   
endfunction : new


task uvml_vseq_c::body();
   
   // TODO Implement uvml_vseq_c::body()
   
endtask : body


`endif // __UVML_VSEQ_SV__
