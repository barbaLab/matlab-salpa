%% Initialize Python to call the python-salpa module
% Check the current path
if isfile('./config.txt') && isfolder('./python-salpa')
    fprintf('Correct working directory.\nInitializing Python environment...');

    % % Set the Python environment from config.txt
    fileID = fopen(fullfile(fileparts(which('SALPA')), 'config.txt'));
    configFile = textscan(fileID,'%s');
    configFile = configFile{1};
    fclose(fileID);

    config = struct();

    for i = 1:length(configFile)
        row = strsplit(configFile{i}, '=');
        config.(row{1}) = row{2};
    end
    config.PYTHON_PATH = strrep(config.PYTHON_PATH, '//', '\');
    config.PYTHON_PATH = strrep(config.PYTHON_PATH, '/', '\');

    env = pyenv();

    if ~strcmp(env.Status, 'Loaded')
        pyenv(Version=config.PYTHON_PATH);

        pyrun(["import importlib", "cpython_salpa = importlib.import_module('.', 'python-salpa')"]);
        fprintf('Done\n');
        addpath(fullfile('./SALPA.m'));
    elseif strcmp(config.PYTHON_PATH, env.Executable)
        pyrun(["import importlib", "cpython_salpa = importlib.import_module('.', 'python-salpa')"]);
        fprintf('Done\n');
        addpath(fullfile('./SALPA.m'));
    else
        fprintf('Failed\n');
        fprintf('A Python environment is already loaded. Restart Matlab.\n');
    end
else
    fprintf('Wrong working directory. Abort.\n');
end

clear();