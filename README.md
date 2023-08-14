# matlab-salpa
This repository aims at allowing the [wagenadl/python-salpa](https://github.com/wagenadl/python-salpa/tree/master) algorithm to be used inside Matlab in a simple way.

## Installation
1) Install `conda`, `miniconda` or `mamba` if not already present.
2) Open a terminal window, move to the desired location and clone this repository with the command:
    ```
    git clone --recurse-submodules https://github.com/FrancescoNegri/matlab-salpa.git
    ```
3) Move inside the new `matlab-salpa` folder:
    ```
    cd matlab-salpa
    ```
4) Create a Python environment from the provided `SALPA.yml` file by typing the following command into the terminal:
    ```
    conda env create --file ./SALPA.yml
    ```
5) Activate such environment by using:
    ```
    conda activate SALPA
    ```
6) Move inside the `python-salpa` subfolder:
    ```
    cd python-salpa
    ```
7) Compile the binaries by running:
    ```
    scons
    ```
    > If this step was successful move on, otherwise try to install Visual Studio (full version) with the C/C++ build tools and repeat steps 6 and 7 from the Developer Command Prompt.
8) Edit the config.txt file and set the path to the correct Python environment:
    ```
    PYTHON_PATH=/path/to/.../envs/SALPA/python.exe
    ```
## Usage
Every time Matlab is launched, change the working directory to the `matlab-salpa` folder, then run the `init.m` script.

> This is a critical step to ensure a proper initialization of the Python environment inside Matlab.

Cheers! Now you should be able to properly call the `salpa` function from Matlab.