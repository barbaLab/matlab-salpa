# matlab-salpa
This repository aims at allowing the [wagenadl/python-salpa](https://github.com/wagenadl/python-salpa/tree/master) algorithm to be used inside Matlab in a simple way.

## Installation
1) Install `conda`, `miniconda` or `mamba` if not already present.
2) Open a terminal inside this folder.
3) Create a Python environment from the provided `SALPA.yml` file by typing the following command into the terminal:
    ```
    conda env create --file ./SALPA.yml
    ```
4) Activate such environment by using:
    ```
    conda activate SALPA
    ```
5) Move inside the `python-salpa` subfolder:
    ```
    cd python-salpa
    ```
6) Compile the binaries by running:
    ```
    scons
    ```
    > If this step was successful move on, otherwise try to install Visual Studio (full version) with the C/C++ build tools and repeat steps 6 and 7 from the Developer Command Prompt.
7) Edit the config.txt file and set the path to the correct Python environment:
    ```
    PYTHON_PATH=/path/to/.../envs/SALPA/python.exe
    ```
## Usage
Every time Matlab is launched, change the working directory to the `matlab-salpa` folder, then run the `init.m` script.

> This is a critical step to ensure a proper initialization of the Python environment inside Matlab.

Cheers! Now you should be able to properly call the `SALPA` function from Matlab.