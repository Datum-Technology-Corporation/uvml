// Copyright ${year} ${name_of_copyright_owner}
// 
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.


`ifndef __UVMT_${name_uppercase}_DUT_WRAP_SV__
`define __UVMT_${name_uppercase}_DUT_WRAP_SV__


/**
 * Module wrapper for ${name_normal_case} RTL DUT. All ports are SV interfaces.
 */
module uvmt_${name}_dut_wrap(
   uvma_${ral_agent_type}_if  ${ral_agent_type}_if,
   uvmt_${name}_probe_if  probe_if
);
   
   // \/ CODE BELOW IS RESPONSABILITY OF DESIGNERS \/
   
   // TODO Instantiate Device Under Test (DUT) and connect it to the interfaces signals
   //      Ex: ${name}_top  dut(
   //             .clk    (${ral_agent_type}_if.clk),
   //             .reset_n(${ral_agent_type}_if.reset_n),
   //             .${ral_agent_type}_data(${ral_agent_type}_if.data),
   //             ...
   //          );
   
   // TODO Connect probe interface signals to design
   //      Ex: assign probe_if.abc = dut.abc;
   
   // /\ CODE ABOVE IS RESPONSABILITY OF DESIGNERS /\
   
endmodule : uvmt_${name}_dut_wrap


`endif // __UVMT_${name_uppercase}_DUT_WRAP_SV__
