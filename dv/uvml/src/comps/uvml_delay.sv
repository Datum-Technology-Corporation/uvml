// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVML_DELAY_SV__
`define __UVML_DELAY_SV__


/**
 * TODO Describe uvml_delay_c
 */
class uvml_delay_c #(
   type T_TRN = uvm_sequence_item
) extends uvm_component;
   
   int unsigned  duration; ///< 
   
   // TLM
   uvm_analysis_export  #(T_TRN)  in_export; ///< 
   uvm_tlm_analysis_fifo#(T_TRN)  in_fifo  ; ///< 
   uvm_analysis_port    #(T_TRN)  out_ap   ; ///< 
   
   
   `uvm_component_param_utils_begin(uvml_delay_c#(.T_TRN(T_TRN)))
      `uvm_field_int(duration, UVM_DEFAULT)
   `uvm_component_utils_end
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvml_delay", uvm_component parent=null);
   
   /**
    * TODO Describe uvml_delay_c::build_phase()
    */
   extern virtual function void build_phase(uvm_phase phase);
   
   /**
    * TODO Describe uvml_delay_c::connect_phase()
    */
   extern virtual function void connect_phase(uvm_phase phase);
   
   /**
    * TODO Describe uvml_delay_c::run_phase()
    */
   extern virtual task run_phase(uvm_phase phase);
   
   /**
    * TODO Describe uvml_delay_c::get_duration()
    */
   extern function int unsigned get_duration();
   
   /**
    * TODO Describe uvml_delay_c::set_duration()
    */
   extern function void set_duration(int unsigned val);
   
endclass : uvml_delay_c


function uvml_delay_c::new(string name="uvml_delay", uvm_component parent=null);
   
   super.new(name, parent);
   
endfunction : new


function void uvml_delay_c::build_phase(uvm_phase phase);
   
   super.build_phase(phase);
   
   // Build TLM objects
   in_export  = new("in_export", this);
   in_fifo    = new("in_fifo"  , this);
   out_ap     = new("out_ap"   , this);
   
endfunction : build_phase


function void uvml_delay_c::connect_phase(uvm_phase phase);
   
   super.connect_phase(phase);
   
   // Connect TLM objects
   in_export.connect(in_fifo.analysis_export);
   
endfunction: connect_phase


task uvml_delay_c::run_phase(uvm_phase phase);
   
   T_TRN  in_trn, out_trn;
   
   super.run_phase(phase);
   
   forever begin
      // Get next transaction and copy it
      in_fifo.get(in_trn);
      out_trn = T_TRN::type_id::create("out_trn");
      out_trn.copy(in_trn);
      
      // Send transaction to analysis port
      #(duration * 1ns);
      out_ap.write(out_trn);
   end
   
endtask: run_phase


function int unsigned uvml_delay_c::get_duration();
   
   return duration;
   
endfunction : get_duration


function void uvml_delay_c::set_duration(int unsigned val);
   
   duration = val;
   
endfunction : set_duration


`endif // __UVML_DELAY_SV__
