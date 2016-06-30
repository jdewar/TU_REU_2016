function [] = sir_plot_contour_c_init_cumu_infected(Q,c_range, init_cumu_infected_range, param)
[c,init_cumu_infected] = meshgrid(c_range,init_cumu_infected_range);
for i = 1:numel(c)
    params1 = param;
    params1.c = c(i);
    params1.init_cumu_infected = init_cumu_infected(i);
    z(i) = Q(params1);
end
z = reshape(z,size(c));

contour(c,init_cumu_infected,z,40);
xlabel('C Values','fontsize',16);
ylabel('Inital Cumulative Infected Values','fontsize',16);
title('Comparing C and Initial Cumulative Infected to Objective Function Value','fontsize',18)
colorbar
end