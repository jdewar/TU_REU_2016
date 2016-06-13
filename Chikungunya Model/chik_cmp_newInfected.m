function [out] = chik_cmp_newInfected(model, infected_real)

newly_infected = get_newly_infected_count(infected_real);

diff1 = model(1:length(newly_infected),5);
diff1(2:end) = diff1(2:end)-diff1(1:end-1);

difference = diff1 - newly_infected';
out = sum((difference.^2));
end