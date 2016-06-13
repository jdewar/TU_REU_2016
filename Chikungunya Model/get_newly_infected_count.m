function [count] = get_newly_infected_count(real_data)

count = real_data;
count(2:end) = real_data(2:end) - real_data(1:end-1);


end

