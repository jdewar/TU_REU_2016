function [y, pop, name] = get_data(country_name, which)
%get_data for Dominican Republic
addpath('../lib')

db = create_database();
bestidx = 1;
bestdist = intmax;

uname = upper(country_name);
for i = 1:length(db)
    cdist = strdist (upper(db(i).name), uname);
    if cdist < bestdist
        bestidx = i;
        bestdist = cdist;
    end
end
c = bestidx;

if exist('which','var')
    switch which
        case 'linear'
            count = db(c).count_linear;
        case 'sparse'
            count = db(c).count_sparse;
        otherwise
            count = db(c).count;
    end
else
    count = db(c).count_linear;
end

y = count(db(c).first_week:end);
pop  = db(c).population;
name = db(c).name;
end

