// Copyright ${year} ${name_of_copyright_owner}
// 
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.


`ifndef __UVME_${name_uppercase}_ST_CHKR_SV__
`define __UVME_${name_uppercase}_ST_CHKR_SV__


/**
 * TODO Describe uvme_${name}_st_chkr
 */
module uvme_${name}_st_chkr (
      uvma_${name}_if  ${name_1}_if,
      uvma_${name}_if  ${name_2}_if
);
   
   `pragma protect begin
   
   // TODO Add assertions to uvme_${name}_st_chkr
   
   `pragma protect end
   
endmodule : uvme_${name}_st_chkr


`endif // __UVME_${name_uppercase}_ST_CHKR_SV__
