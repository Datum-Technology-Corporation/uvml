#! /bin/bash
########################################################################################################################
## Copyright 2021-2022 Datum Technology Corporation
## SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
########################################################################################################################


# Launched from uvml project sim dir
mio sim     uvmt_st -CE
mio sim     uvmt_st -S -t traffic     -s 1 -c
mio sim     uvmt_st -S -t file_read   -s 1 -c
mio sim     uvmt_st -S -t file_write  -s 1 -c
#mio sim     uvmt_st -S -t vector_file -s 1 -c
mio results uvmt_st results
mio cov     uvmt_st
