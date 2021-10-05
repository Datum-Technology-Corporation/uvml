#! python3
# Copyright 2021 Datum Technology Corporation
# SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
########################################################################################################################
# Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
# with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
#                                       https://solderpad.org/licenses/SHL-2.1/
# Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
# an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations under the License.
########################################################################################################################

# IMPORTS
from datetime import date


print("Moore.io UVM Agent Template - Simplex, no layers - v1p0")
name = input("Please enter the (short) name:").lower()
name_uppercase = name.upper()
name_normal_case = input("Please enter the (full) name:")
name_of_copyright_holder = input("Please enter the name of the copyright holder:")
year = date.today().year


file_paths = {
    "bin/package.py",
    "docs/agent_block_diagram.svg",
    "examples/instantiation.sv",
    "examples/sequence.sv",
    "src/comps/agent.sv",
    "src/comps/cov_model.sv",
    "src/comps/drv.sv",
    "src/comps/mon_trn_logger.sv",
    "src/comps/mon.sv",
    "src/comps/seq_item_logger.sv",
    "src/comps/sqr.sv",
    "src/obj/cfg.sv",
    "src/obj/cntxt.sv",
    "src/obj/mon_trn.sv",
    "src/seq/base_seq.sv",
    "src/seq/seq_item.sv",
    "src/constants.sv",
    "src/if_chkr.sv",
    "src/if.sv",
    "src/macros.sv",
    "src/pkg.flist",
    "src/pkg.sv",
    "src/tdefs.sv",
    "README.md"
    }


file_paths_templates = {
    "bin/package.py",
    "docs/agent_block_diagram.svg",
    "examples/instantiation.sv",
    "examples/sequence.sv",
    "src/comps/uvma_$name_agent.sv",
    "src/comps/uvma_$name_cov_model.sv",
    "src/comps/uvma_$name_drv.sv",
    "src/comps/uvma_$name_mon_trn_logger.sv",
    "src/comps/uvma_$name_mon.sv",
    "src/comps/uvma_$name_seq_item_logger.sv",
    "src/comps/uvma_$name_sqr.sv",
    "src/obj/uvma_$name_cfg.sv",
    "src/obj/uvma_$name_cntxt.sv",
    "src/obj/uvma_$name_mon_trn.sv",
    "src/seq/uvma_$name_base_seq.sv",
    "src/seq/uvma_$name_seq_item.sv",
    "src/uvma_$name_constants.sv",
    "src/uvma_$name_if_chkr.sv",
    "src/uvma_$name_if.sv",
    "src/uvma_$name_macros.sv",
    "src/uvma_$name_pkg.flist",
    "src/uvma_$name_pkg.sv",
    "src/uvma_$name_tdefs.sv",
    "README.md"
   }


def process_file(path, file_path_template):
    
