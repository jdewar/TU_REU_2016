function [y, pop] = get_data(country_name)
%get_data for Dominican Republic
db = create_database();
c = 1;
for i = 1:length(db)
    if strcmp(db(i).name, country_name)
        c = i;
    end
end
count = db(c).count_linear;
y = count(db(c).first_week:end);
pop  = db(c).population;
end

