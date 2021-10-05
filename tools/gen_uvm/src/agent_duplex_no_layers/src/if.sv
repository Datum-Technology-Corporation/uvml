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
 * Encapsulates all signals and clocking of an ${name_normal_case} interface.
 * Used by monitor (uvma_${name}_mon_c) and driver (uvma_${name}_drv_c).
 */
interface uvma_${name}_if (
   input  clk  ,
   input  reset
);
   
   // ${direction_rx_normal_case}
   // TODO Add uvma_${name}_if ${direction_rx_normal_case} signals
   //      Ex: wire         ${direction_rx}_ready;
   //          wire         ${direction_rx}_enable;
   //          wire [31:0]  ${direction_rx}_data;
   
   // ${direction_tx_normal_case}
   // TODO Add uvma_${name}_if ${direction_tx_normal_case} signals
   //      Ex: wire         ${direction_tx}_ready;
   //          wire         ${direction_tx}_enable;
   //          wire [31:0]  ${direction_tx}_data;
   
   
   /**
    * Used by target DUT.
    */
   clocking dut_cb @(posedge clk);
      // TODO Implement uvma_${name}_if::dut_cb()
      //      Ex: input   ${direction_rx}_ready,
      //                  ${direction_tx}_ready;
      //          output  ${direction_rx}_enable,
      //                  ${direction_rx}_data,
      //                  ${direction_tx}_enable,
      //                  ${direction_tx}_data;
   endclocking : dut_cb
   
   /**
    * Used by uvma_${name}_drv_c ${direction_rx_normal_case}
    */
   clocking drv_${direction_rx}_cb @(posedge clk);
      // TODO Implement uvma_${name}_if::drv_${direction_rx}_cb()
      //      Ex: input   ${direction_rx}_enable,
      //                  ${direction_rx}_data  ;
      //          output  ${direction_rx}_ready ;
   endclocking : drv_${direction_rx}_cb
   
   /**
    * Used by uvma_${name}_drv_c ${direction_tx_normal_case}
    */
   clocking drv_${direction_tx}_cb @(posedge clk);
      // TODO Implement uvma_${name}_if::drv_${direction_tx}_cb()
      //      Ex: input   ${direction_tx}_ready ;
      //          output  ${direction_tx}_enable,
      //                  ${direction_tx}_data  ;
   endclocking : drv_${direction_tx}_cb
   
   /**
    * Used by uvma_${name}_mon_c ${direction_rx_normal_case}
    */
   clocking mon_${direction_rx}_cb @(posedge clk);
      // TODO Implement uvma_${name}_if::mon_${direction_rx}_cb()
      //      Ex: input  ${direction_rx}_ready ,
      //                 ${direction_rx}_enable,
      //                 ${direction_rx}_data  ;
   endclocking : mon_${direction_rx}_cb
   
   /**
    * Used by uvma_${name}_mon_c ${direction_tx_normal_case}
    */
   clocking mon_${direction_tx}_cb @(posedge clk);
      // TODO Implement uvma_${name}_if::mon_${direction_tx}_cb()
      //      Ex: input  ${direction_tx}_ready ,
      //                 ${direction_tx}_enable,
      //                 ${direction_tx}_data  ;
   endclocking : mon_${direction_tx}_cb
   
   
   modport dut_mp(clocking dut_cb);
   modport active_${direction_rx}_mp (clocking drv_${direction_rx}_cb);
   modport active_${direction_tx}_mp (clocking drv_${direction_tx}_cb);
   modport passive_${direction_rx}_mp(clocking mon_${direction_rx}_cb);
   modport passive_${direction_tx}_mp(clocking mon_${direction_tx}_cb);
   
endinterface : uvma_${name}_if


`endif // __UVMA_${name_uppercase}_IF_SV__
