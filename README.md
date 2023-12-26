# matlab-salpa
This repository aims at allowing the [wagenadl/python-salpa](https://github.com/wagenadl/python-salpa/tree/master) algorithm to be used inside Matlab in a simple way.

## Installation
1) Install `conda`, `miniconda` or `mamba` if not already present.
2) Open a terminal window, move to the desired location and clone this repository with the command:
    ```
    git clone --recurse-submodules https://github.com/FrancescoNegri/matlab-salpa.git
    ```
3) Run `install.m` located in the `matlab-salpa` folder.
    > If SALPA binaries fail to compile try to install Visual Studio (full version) with the C/C++ build tools and repeat the installation
    process.

Cheers! Now you should be able to properly call the `salpa` function from Matlab.