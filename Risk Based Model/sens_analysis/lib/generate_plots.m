function generate_plots(pbase, prange, ptitles, xlbl, dirname, blackboxHandle)
set(0,'defaultlinelinewidth',1.5)

ylbls = {'R0','Number of Total Infected','Rinf'};


pnames = fieldnames(pbase);
plen   = length(pnames);
q = blackboxHandle(pbase); % Calculate the baseline
qnames = fieldnames(q);
qlen   = length(qnames);
data = cell(1,plen);

for i=1:plen
    pn = pnames{i};
    Pfname = sprintf('%s/P%d-%s',dirname,i,pn);
    if exist([Pfname '.mat'],'file')
        readdata = load(Pfname);
        disp(['Loaded ' Pfname])
        data{i} = readdata.gendata;
    else
        gendata = generate_data(pbase, prange.(pn), ...
            i, true, blackboxHandle);
        save(Pfname,'gendata');
        data{i} = gendata;
    end 
end

for i=1:qlen
    % Aggregate the data
    tq = qnames{i};
    ax = realmin; in = realmax;
    for j=plen:-1:1
%   keyboard        
        yR{j} = [data{j}.(tq)];
        ax = max(ax, max(yR{j}));
        in = min(in, min(yR{j}));
    end
    % Save the MATLAB data
    Qfname = sprintf('%s/Q%d-%s',dirname,i,qnames{i});
    save(Qfname,'yR');

    % Plot set of curves for each QOI 
    
    figure('Position',[1 1 800 600])
    for j=1:plen
        a=subplot('Position', ...
            [.92*(j-1)/plen+.08, 0.1, .90/plen-.01, .85]);
        tp = pnames{j};
        plot(prange.(tp), yR{j}, ...
            pbase.(tp), q.(tq), '*','MarkerSize',14);
        axis(a,'tight')
        xlabel(xlbl,'fontsize',14)
        if j > 1
            set(a,'YTickLabel',{})
        else
            ylabel(ylbls{i},'fontsize',14)
        end

        min_in = min(in);
        max_ax = max(ax);
        ylim([min_in-min_in/10,max_ax+max_ax/10])
        title(ptitles{j},'fontsize',16)
    end
    % Save the plot
    Plotfname = sprintf('%s/Q%d-%s',dirname,i,qnames{i});
%    export_fig(Plotfname, '-pdf', '-transparent')
end

end
