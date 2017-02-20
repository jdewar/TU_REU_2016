function generate_plots_3(pbase, prange, ptitles, xlbls, dirname, blackboxHandle)

set(0,'defaultlinelinewidth',1.5)

%ylbls = {'Total Exposed','Proportion Exposed to Medical','Proportion Exposed to Funerals','Proportion Exposed to Dead'};
ylbls = {'Total Exposed','Total Dead'};

pnames = fieldnames(pbase);
plen   = length(pnames);

q = blackboxHandle(pbase); % Calculate the baseline
qnames = fieldnames(q);
qlen   = length(qnames);

data = cell(1,plen);

for i=1:plen
    pn = pnames{i};
   
    gendata = generate_data(pbase, prange.(pn), ...
        i, true, blackboxHandle);
    data{i} = gendata;
end

for i=1:qlen
    % Aggregate the data
    tq = qnames{i};
    ax = realmin; in = realmax;
    for j=plen:-1:1
        yR{j} = [data{j}.(tq)];
        ax = max(ax, max(yR{j}));
        in = min(in, min(yR{j}));
    end
    % Save the MATLAB data
%    Qfname = sprintf('%s/Q%d-%s',dirname,i,qnames{i});
%    save(Qfname,'yR');

    % Plot set of curves for each QOI 
    
    figure(6+i)%'Position',[1 1 800 600])
    for j=1:plen
        a=subplot('Position', ...
            [.92*(j-1)/plen+.08, 0.13, .90/plen-.01, .82]);
        tp = pnames{j};
        plot(prange.(tp), yR{j}, ...
            pbase.(tp), q.(tq), '*','MarkerSize',14);
        axis(a,'tight')
        set(gca,'fontsize',16)
        xlabel(xlbls{j},'interpreter','latex','fontsize',20)
        if j > 1
            set(a,'YTickLabel',{})
        else
            ylabel(ylbls{i})
        end
        ylim([min(in),max(ax)])
        title(ptitles{j},'fontsize',18)
    end
    % Save the plot
%    Plotfname = sprintf('%s/Q%d-%s',dirname,i,qnames{i});
end

end
