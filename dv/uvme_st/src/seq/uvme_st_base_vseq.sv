// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_ST_BASE_VSEQ_SV__
`define __UVME_ST_BASE_VSEQ_SV__


/**
 * Abstract object from which all other Moore.io UVM Extension Library virtual sequences extend.
 * Does not generate any sequence items of its own. Subclasses must be run on
 * Moore.io UVM Extension Library Virtual Sequencer (uvme_st_vsqr_c) instance.
 */
class uvme_st_base_vseq_c extends uvml_vseq_c#(
   .REQ(uvml_seq_item_c),
   .RSP(uvml_seq_item_c)
);
   
   // Environment handles
   uvme_st_cfg_c    cfg;
   uvme_st_cntxt_c  cntxt;
   
   
   `uvm_object_utils(uvme_st_base_vseq_c)
   `uvm_declare_p_sequencer(uvme_st_vsqr_c)
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvme_st_base_vseq");
   
   /**
    * Retrieve cfg and cntxt handles from p_sequencer.
    */
   extern virtual task pre_start();
   
endclass : uvme_st_base_vseq_c


function uvme_st_base_vseq_c::new(string name="uvme_st_base_vseq");
   
   super.new(name);
   
endfunction : new


task uvme_st_base_vseq_c::pre_start();
   
   cfg   = p_sequencer.cfg;
   cntxt = p_sequencer.cntxt;
   
endtask : pre_start


`endif // __UVME_ST_BASE_VSEQ_SV__
