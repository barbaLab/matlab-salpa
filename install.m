installSalpa()

function installSalpa()
    currentPath = pwd();

    newPath = mfilename('fullpath');
    [newPath, ~, ~] = fileparts(newPath);
    cd(newPath);

    fprintf('Creating SALPA virtual environment...');
    [status, cmdout] = system('conda env create --file ./SALPA.yml');
    if status ~= 0
        error('Could not create SALPA python environment.\nCommand output:\n%s', cmdout);
    end
    fprintf(' Done.\n');

    [~, cmdout] = system('conda env list');
    pythonPath = split(cmdout, 'SALPA');
    pythonPath = strtrim(pythonPath{2});
    pythonPath = strcat(pythonPath, 'SALPA\python.exe');

    fprintf('Compiling SALPA binaries...');
    cd(fullfile(newPath, 'python-salpa'));
    [status, ~] = system('conda activate SALPA & scons');
    if status ~= 0
        error('SALPA could not be compiled.\nCheck if C/C++ build tools are properly installed.');
    end
    fprintf(' Done.\n');

    cd(newPath);
    fileID = fopen('./config.txt', 'w');
    fprintf(fileID, 'PYTHON_PATH=%s', pythonPath);
    fclose(fileID);

    fprintf('Adding matlab-salpa to the path...');
    addpath(newPath);
    savepath();
    fprintf(' Done.\n');

    cd(currentPath);
    fprintf('matlab-salpa is now installed and ready to be used.\n');
end