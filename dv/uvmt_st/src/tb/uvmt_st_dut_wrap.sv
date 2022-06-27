// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
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
