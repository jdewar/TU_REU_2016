function y0 = generate_data(pbase, prange, which, doOutput, blackboxHandle, varargin)

names = fieldnames(pbase);

prlen = length(prange);

parfor j=1:prlen
    x0 = pbase;
    x0.(names{which}) = prange(j);
    tic; out = blackboxHandle(x0, varargin{:}); t=toc;
    y0(j) = out;
    if doOutput
        fprintf(' P:%d  |  %3d/%3d  |  %6gs\n', ...
            which, j, prlen, t)
    end
end

if doOutput
    fprintf('--------------------------------\n')
end

end
