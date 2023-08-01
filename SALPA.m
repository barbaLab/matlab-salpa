function output = salpa(signal, tau, varargin)
    validNumPosCheck = @(x) isnumeric(x) && (x >= 0);
    
    parser = inputParser();
    addRequired(parser, 'signal', @isnumeric);
    addRequired(parser, 'tau', @(x) isnumeric(x) && all(x > 0));
    addOptional(parser, 'stimIdxs', 1, @(x) isnumeric(x) && all(x > 0));
    addParameter(parser, 'rail1', [], @isnumeric);
    addParameter(parser, 'rail2', [], @isnumeric);
    addParameter(parser, 'thresh', [], @isnumeric);
    addParameter(parser, 'tBlankDepeg', [], validNumPosCheck);
    addParameter(parser, 'tAhead', [], @validNumPosCheck);
    addParameter(parser, 'tChi2', [], @validNumPosCheck);
    addParameter(parser, 'tForcePeg', [], @validNumPosCheck);
    addParameter(parser, 'hasNan', false, @islogical);

    parse(parser, signal, tau, varargin{:});

    signal = parser.Results.signal;
    stimIdxs = parser.Results.stimIdxs;
    tau = parser.Results.tau;
    rail1 = parser.Results.rail1;
    rail2 = parser.Results.rail2;
    thresh = parser.Results.thresh;
    tBlankDepeg = parser.Results.tBlankDepeg;
    tAhead = parser.Results.tAhead;
    tChi2 = parser.Results.tChi2;
    tForcePeg = parser.Results.tForcePeg;
    hasNan = parser.Results.hasNan;

    if iscolumn(signal)
        output = signal';
    else
        output = signal;
    end

    if iscolumn(stimIdxs)
        stimIdxs = stimIdxs';
    end

    stimIdxs = [1, stimIdxs];
    artifactNSamples = diff([stimIdxs, length(output)]);

    for idx = 1:numel(stimIdxs)
        data = output((1:artifactNSamples(idx)) + stimIdxs(idx) - 1);
        data = pyrunfile('wrapper.py', 'data', data=data, ...
            tau=tau, rail1=rail1, rail2=rail2, thresh=thresh, ...
            t_blankdepeg=tBlankDepeg, t_ahead=tAhead, ...
            t_chi2=tChi2, t_forcepeg=tForcePeg);

        output((1:artifactNSamples(idx)) + stimIdxs(idx) - 1) = double(data);
    end

    if ~hasNan
        output(isnan(output)) = 0;
    end

    if iscolumn(signal)
        output = output';
    end
end