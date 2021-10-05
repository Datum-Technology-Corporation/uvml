// Copyright ${year} ${name_of_copyright_owner}
// 
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.


`ifndef __UVMA_${name_uppercase}_TDEFS_SV__
`define __UVMA_${name_uppercase}_TDEFS_SV__


typedef enum {
   UVMA_${name_uppercase}_RESET_STATE_PRE_RESET ,
   UVMA_${name_uppercase}_RESET_STATE_IN_RESET  ,
   UVMA_${name_uppercase}_RESET_STATE_POST_RESET
} uvma_${name}_reset_state_enum;


typedef enum int unsigned {
   UVMA_${name_uppercase}_LOGGING_DEPTH_AGENT,
   UVMA_${name_uppercase}_LOGGING_DEPTH_LAYER,
   UVMA_${name_uppercase}_LOGGING_DEPTH_FULL
} uvma_${name}_logging_depth_enum;

typedef enum {
   UVMA_${name_uppercase}_LAYER_${layer_name_uppercase}
} uvma_${name}_layer_enum;

typedef enum {
   UVMA_${name_uppercase}_DIRECTION_${direction_rx_uppercase},
   UVMA_${name_uppercase}_DIRECTION_${direction_tx_uppercase}
} uvma_${name}_direction_enum;


`endif // __UVMA_${name_uppercase}_TDEFS_SV__
