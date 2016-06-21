function [full_count] = combine_data(data2014,newly_infected2015)
c = length(data2014)
full_count = data2014;
for i = 1:length(newly_infected2015)
    full_count(c+i) = full_count(c+i-1) + newly_infected2015(i);
end
end

