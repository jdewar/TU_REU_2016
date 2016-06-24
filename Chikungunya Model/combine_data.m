function [full_count] = combine_data(country)
[data2014] = get_data(country);
[data2015] = get_data2015(country);
newly_infected2015 = get_newly_infected_count(data2015);
c = length(data2014);
full_count = data2014;
if c > 0
    for i = 1:length(newly_infected2015)
        full_count(c+i) = full_count(c+i-1) + newly_infected2015(i);
    end
end
end

