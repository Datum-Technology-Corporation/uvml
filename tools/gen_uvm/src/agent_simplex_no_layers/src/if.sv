// Copyright ${year} ${name_of_copyright_owner}
// 
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.


`ifndef __UVMA_${name_uppercase}_IF_SV__
`define __UVMA_${name_uppercase}_IF_SV__


/**
 * Encapsulates all signals and clocking of ${name_normal_case} interface.  Used by monitor (uvma_${name}_mon_c)
 * and driver (uvma_${name}_drv_c).
 */
interface uvma_${name}_if (
   input  clk    ,
   input  reset_n
);
   
   // TODO Add uvma_${name}_if signals
   // Ex:  wire        enable;
   //      wire [7:0]  data;
   
   
   /**
    * Used by target DUT.
    */
   clocking dut_cb @(posedge clk or reset_n);
      // TODO Implement uvma_${name}_if::dut_cb()
      //      Ex: input  enable,
      //                 data  ;
   endclocking : dut_cb
   
   /**
    * Used by uvma_${name}_drv_c.
    */
   clocking drv_cb @(posedge clk or reset_n);
      // TODO Implement uvma_${name}_if::drv_cb()
      //      Ex: output  enable,
      //                  data  ;
   endclocking : drv_cb
   
   /**
    * Used by uvma_${name}_mon_c.
    */
   clocking mon_cb @(posedge clk or reset_n);
      // TODO Implement uvma_${name}_if::mon_cb()
      //      Ex: input  enable,
      //                 data  ;
   endclocking : mon_cb
   
   
   modport dut_mp    (clocking dut_cb);
   modport active_mp (clocking drv_cb);
   modport passive_mp(clocking mon_cb);
   
endinterface : uvma_${name}_if


`endif // __UVMA_${name_uppercase}_IF_SV__
