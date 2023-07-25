function sig = SALPA(sig, p)

    returnColumn = false;
    if iscolumn(sig)
        sig = sig';
        returnColumn = true;
    end

    p.StimI = [1, p.StimI];
    artifactNSamples = diff([p.StimI, length(sig)]);

    for i = 1:numel(p.StimI)
        data = sig((1:artifactNSamples(i)) + p.StimI(i) - 1);
        data = pyrunfile('wrapper.py', 'data', data=data, tau=p.SALPA.tau, thresh=p.SALPA.thresh);

        sig((1:artifactNSamples(i)) + p.StimI(i) - 1) = double(data);
    end

    sig(isnan(sig)) = 0;

    if returnColumn
        sig = sig';
    end
end