function [y, pop, name, firstweek] = get_data2015(country_name)

addpath('../lib') % for strdist

[db, names, pops] = create_database_2015();
bestidx = 1;
bestdist = intmax;
uname = upper(country_name);
for i = 1:length(names)
    cdist = strdist(upper(names{i}), uname);
    if cdist < bestdist
        bestidx = i;
        bestdist = cdist;
    end
end
c = bestidx;

name = names{c};
pop = pops(c) * 1000;

country_data = db(c,:);

firstweek = find(country_data,1);

y = country_data(firstweek:end);



    function [output, names, pops] = create_database_2015()
        
        fname = 'PAHO data.csv';

        PAHO_2015 = csvread(fname,1,1,'B2..JG59');

        rtable = readtable(fname);
        rtable.Country(1:end-3);

        subtotals = [5 13 23 29 35 57];
        data_rows = setdiff(1:57, subtotals);

        pops = PAHO_2015(data_rows,1);

        input = PAHO_2015(data_rows,2:end);
        names = rtable.Country(data_rows);
        [rows, cols] = size(input);

        weeks = cols/5;

        output = zeros(rows,weeks);

        for week = 1:weeks
        j = (week-1)*5;
        week_idx = j+1;
        susc_idx = j+2;
        conf_idx = j+3;
        % import_idx = j+4;
        % death_idx = j+5;
        % data_idx = susc_idx:death_idx;

            for row = 1:rows
                data_from = input(row, week_idx);
                if data_from == 0
                    continue
                end
                output(row,data_from:end) = sum(input(row,susc_idx:conf_idx));
            end


        % this finds the weird data missing at the end
        % (input(:,week_idx) == 0) | (sum(input(:,data_idx),2) > 0)

        end

        output = output(:,1:end-1);

    end
end