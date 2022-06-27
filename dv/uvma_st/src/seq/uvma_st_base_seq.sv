// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_ST_BASE_SEQ_SV__
`define __UVMA_ST_BASE_SEQ_SV__


/**
 * Abstract object from which all other Extension Library Self-Test agent sequences must extend.  Subclasses must be run
 * on Extension Library Self-Test sequencer (uvma_st_sqr_c) instance.
 */
class uvma_st_base_seq_c extends uvml_seq_c#(
   .REQ(uvma_st_seq_item_c),
   .RSP(uvma_st_seq_item_c)
);
   
   // Agent handles
   uvma_st_cfg_c    cfg;
   uvma_st_cntxt_c  cntxt;
   
   
   `uvm_object_utils(uvma_st_base_seq_c)
   `uvm_declare_p_sequencer(uvma_st_sqr_c)
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvma_st_base_seq");
   
   /**
    * Assigns cfg and cntxt handles from p_sequencer.
    */
   extern virtual task pre_start();
   
endclass : uvma_st_base_seq_c


function uvma_st_base_seq_c::new(string name="uvma_st_base_seq");
   
   super.new(name);
   
endfunction : new


task uvma_st_base_seq_c::pre_start();
   
   cfg   = p_sequencer.cfg;
   cntxt = p_sequencer.cntxt;
   
endtask : pre_start


`endif // __UVMA_ST_BASE_SEQ_SV__
