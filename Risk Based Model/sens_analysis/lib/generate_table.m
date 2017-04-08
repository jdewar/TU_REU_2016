function generate_table(params, dirname, blackboxHandle)

Pnames = fieldnames(params);
Plen  = length(Pnames);

% Calculate sensitivity and write out a LaTeX table
[sa, Qnames] = sens_analysis(params, blackboxHandle);

Qlen = length(Qnames);

fname = sprintf('%s/sensitivity_table.tex',dirname);

latextable(sa, 'Horiz', Pnames, 'Vert', Qnames,...
    'Hline', [0:Qlen,NaN], 'Vline', [0:Plen,NaN],...
    'name', fname, 'format', '%.2g');

fname = sprintf('%s/sensitivity_table_pivot.tex',dirname);

latextable(sa', 'Horiz', Qnames, 'Vert', Pnames,...
    'Hline', [0:Plen,NaN], 'Vline', [0:Qlen,NaN],...
    'name', fname, 'format', '%.2g');



end