// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVML_MON_TRN_SV__
`define __UVML_MON_TRN_SV__


/**
 * TODO Describe uvml_mon_trn_c
 */
class uvml_mon_trn_c extends uvm_sequence_item;
   
   // Fields
   int unsigned  __uid            ; ///< TODO Describe uvml_mon_trn_c::__uid
   bit           __may_drop       ; ///< TODO Describe uvml_mon_trn_c::__may_drop
   bit           __has_error      ; ///< TODO Describe uvml_mon_trn_c::__has_error
   realtime      __timestamp_start; ///< TODO Describe uvml_mon_trn_c::__timestamp_start
   realtime      __timestamp_end  ; ///< TODO Describe uvml_mon_trn_c::__timestamp_end
   
   protected static int unsigned  __last_uid = 0; ///< TODO Describe uvml_mon_trn_c::__last_uid
   
   
   `uvm_object_utils_begin(uvml_mon_trn_c)
      
   `uvm_object_utils_end
   
   
   /**
    * Sets default field values.
    */
   extern function new(string name="uvml_mon_trn");
   
   /**
    * TODO Describe uvml_mon_trn_c::get_uid()
    */
   extern function int unsigned get_uid();
   
   /**
    * TODO Describe uvml_mon_trn_c::get_may_drop()
    */
   extern function bit get_may_drop();
   
   /**
    * TODO Describe uvml_mon_trn_c::set_may_drop()
    */
   extern function void set_may_drop(bit val);
   
   /**
    * TODO Describe uvml_mon_trn_c::has_error()
    */
   extern function bit has_error();
   
   /**
    * TODO Describe uvml_mon_trn_c::set_error()
    */
   extern function void set_error(bit val);
   
   /**
    * TODO Describe uvml_mon_trn_c::get_timestamp_start()
    */
   extern function realtime get_timestamp_start();
   
   /**
    * TODO Describe uvml_mon_trn_c::set_timestamp_start()
    */
   extern function void set_timestamp_start(realtime val);
   
   /**
    * TODO Describe uvml_mon_trn_c::get_timestamp_end()
    */
   extern function realtime get_timestamp_end();
   
   /**
    * TODO Describe uvml_mon_trn_c::set_timestamp_end()
    */
   extern function void set_timestamp_end(realtime val);
   
   /**
    * TODO Describe uvml_mon_trn_c::get_metadata()
    */
   extern function uvml_metadata_t get_metadata();
   
endclass : uvml_mon_trn_c


function uvml_mon_trn_c::new(string name="uvml_mon_trn");
   
   super.new(name);
   __uid             = __last_uid++;
   __may_drop        = 0;
   __has_error       = 0;
   __timestamp_start = $realtime();
   __timestamp_end   = $realtime();
   
endfunction : new


function int unsigned uvml_mon_trn_c::get_uid();
   
   return __uid;
   
endfunction : get_uid


function bit uvml_mon_trn_c::get_may_drop();
   
   return __may_drop;
   
endfunction : get_may_drop


function void uvml_mon_trn_c::set_may_drop(bit val);
   
   __may_drop = val;
   
endfunction : set_may_drop


function bit uvml_mon_trn_c::has_error();
   
   return __has_error;
   
endfunction : has_error


function void uvml_mon_trn_c::set_error(bit val);
   
   __has_error = val;
   
endfunction : set_error


function realtime uvml_mon_trn_c::get_timestamp_start();
   
   return __timestamp_start;
   
endfunction : get_timestamp_start


function void uvml_mon_trn_c::set_timestamp_start(realtime val);
   
   __timestamp_start = val;
   
endfunction : set_timestamp_start


function realtime uvml_mon_trn_c::get_timestamp_end();
   
   return __timestamp_end;
   
endfunction : get_timestamp_end


function void uvml_mon_trn_c::set_timestamp_end(realtime val);
   
   __timestamp_end = val;
   
endfunction : set_timestamp_end


function uvml_metadata_t uvml_mon_trn_c::get_metadata();
   
   uvml_metadata_t  empty_set;
   return empty_set;
   
endfunction : get_metadata


`endif // __UVML_MON_TRN_SV__
