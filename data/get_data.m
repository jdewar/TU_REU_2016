function [y, pop, name, firstweek] = get_data(country_name, which)
%GET_DATA make a database (slow) and return data closest to name given

addpath('../lib') % for strdist

db = create_database();
bestidx = 1;
bestdist = intmax;

uname = upper(country_name);
for i = 1:length(db)
    cdist = strdist(upper(db(i).name), uname);
    if cdist < bestdist
        bestidx = i;
        bestdist = cdist;
    end
end
c = bestidx;

[y, pop, name, firstweek] = data_from_entry(db(c));

end

