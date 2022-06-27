// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_ST_IF_SV__
`define __UVMA_ST_IF_SV__


/**
 * Encapsulates all signals and clocking for the Moore.io UVM Extension Library Self-Test Agent.  Used by monitor
 * (uvma_st_mon_c) and driver (uvma_st_drv_c).
 */
interface uvma_st_if (
   input  clk    ,
   input  reset_n
);
   // Simplest interface possible
   wire        enable;
   wire [7:0]  data  ;
   
   
   /**
    * Used by target DUT.
    */
   clocking dut_cb @(posedge clk);
      input  enable,
             data  ;
   endclocking : dut_cb
   
   /**
    * Used by uvma_st_drv_c.
    */
   clocking drv_cb @(posedge clk);
      output  enable,
              data  ;
   endclocking : drv_cb
   
   /**
    * Used by uvma_st_mon_c.
    */
   clocking mon_cb @(posedge clk);
      input  enable,
             data  ;
   endclocking : mon_cb
   
   
   modport dut_mp(clocking dut_cb);
   modport drv_mp(clocking drv_cb);
   modport mon_mp(clocking mon_cb);
   
endinterface : uvma_st_if


`endif // __UVMA_ST_IF_SV__
