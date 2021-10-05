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


`ifndef __UVMT_ST_DUT_WRAP_SV__
`define __UVMT_ST_DUT_WRAP_SV__


/**
 * Module wrapper for Moore.io UVM Extension LIbrary RTL DUT. All ports are SV interfaces.
 */
module uvmt_st_dut_wrap(
   uvma_st_if  tx_if,
   uvma_st_if  rx_if
);
   
   logic        buffer_enable;
   logic [7:0]  buffer_data  ;
   
   always @(tx_if.dut_mp.dut_cb) begin
      if (tx_if.reset_n === 1'b1) begin
         if (tx_if.dut_mp.dut_cb.enable === 1'b1) begin
            buffer_data   <= tx_if.data  ;
            buffer_enable <= tx_if.enable;
         end
      end
      else begin
         buffer_data   <= 8'h00;
         buffer_enable <= 1'b0;
      end
   end
   
   assign rx_if.enable = buffer_enable;
   assign rx_if.data   = buffer_data  ;
   
endmodule : uvmt_st_dut_wrap


`endif // __UVMT_ST_DUT_WRAP_SV__
