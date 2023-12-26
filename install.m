installSalpa()

function installSalpa()
    currentPath = pwd();

    newPath = mfilename('fullpath');
    [newPath, ~, ~] = fileparts(newPath);
    cd(newPath);

    fprintf('Creating SALPA virtual environment...');
    [status, cmdout] = system('conda env create --file ./SALPA.yml');
    if status ~= 0
        [status, ~] = system('conda activate SALPA');
        if status ~= 0
            error('Could not create SALPA python environment.\nCommand output:\n%s', cmdout);
        else
            fprintf(' Failed.\n');
            fprintf('SALPA environment already exists. ');
            answer = input('Do you want to use it? [Y/n]', 's');
            if answer == 'n'
                answer = input('Do you want to re-create SALPA virtual environment? [y/N]', 's');
                if answer == 'y'
                    fprintf('Removing SALPA virtual environment...');
                    [~, ~] = system('conda env remove -n SALPA');
                    fprintf(' Done.\n');
                    installSalpa();
                    return;
                else
                    fprintf('Aborted.\n');
                    return;
                end
            end
        end
    else
        fprintf(' Done.\n');
    end

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