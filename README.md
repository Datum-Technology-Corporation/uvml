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
**1. Change directory to 'sim'**

This is from where all jobs will be launched.
```
cd ./sim
```

**2. Project Setup**

Only needs to be done once, or when libraries must be updated. This will pull in dependencies from the web.
```
./setup_project.py
```

**3. Terminal Setup**

This must be done per terminal. The script included in this project is for bash:

```
export VIVADO=/path/to/vivado/bin # Set locaton of Vivado installation
source ./setup_terminal.sh
```

**4. Launch**

All jobs for simulation are performed via `dvm`.

> At any time, you can invoke its built-in documentation:

```
dvm --help
```

> To run test 'all_access' with seed '1' and wave capture enabled:

```
clear && dvm all uvmt_st -t traffic -s 1 -w
```
