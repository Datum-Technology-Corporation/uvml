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
