function [y, pop, name, firstweek] = get_data(country_name, which)
%GET_DATA make a database (slow) and return data closest to name given
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
        case 'confirmed'
            count = db(c).count_confirmed;
        case 'linear_newinf'
            inter = db(c).count_linear;
            count = [inter(1), inter(2:end) - inter(1:end-1)];
        otherwise
            count = db(c).count;
    end
else
    count = db(c).count_linear;
end

firstweek = db(c).first_week;
y = count(firstweek:end);
pop  = db(c).population;
name = db(c).name;
end

