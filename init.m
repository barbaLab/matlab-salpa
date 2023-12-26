function init()
    currentPath = pwd();

    newPath = mfilename('fullpath');
    [newPath, ~, ~] = fileparts(newPath);
    cd(newPath);

    % Set the Python environment from config.txt
    fileID = fopen('./config.txt');
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
        pyenv(Version=config.PYTHON_PATH, ExecutionMode='InProcess');
        pyrun(["import importlib", "cpython_salpa = importlib.import_module('.', 'python-salpa')"]);
    elseif strcmp(config.PYTHON_PATH, env.Executable)
        pyrun(["import importlib", "cpython_salpa = importlib.import_module('.', 'python-salpa')"]);
    else
        error('A wrong Python environment is already loaded. Restart Matlab.\n');
    end

    cd(currentPath);
end