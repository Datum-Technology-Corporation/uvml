# About
## [Home Page](https://datum-technology-corporation.github.io/uvml/)
The Moore.io UVM Extensions Library is *the* must-have library in all your digital design simulations.  This project consists of the library (`uvml_pkg`), the self-testing agent (`uvma_st_pkg`), the self-testing UVM environment (`uvme_st_pkg`) and the test bench (`uvmt_st_pkg`) to verify the library against itself.

## IP
* DV
> * uvml
> * uvma_st
> * uvme_st
> * uvmt_st
* RTL
* Tools
> * dvm


# Simulation
```
cd ./sim
cat ./README.md
./setup_project.py
source ./setup_terminal.sh
export VIVADO=/path/to/vivado/install
dvm --help
clear && dvm all uvmt_st -t traffic -s 1 -w
```
