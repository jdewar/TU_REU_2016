function [] = math4910_plot_contour(Q, param,range_init_cumu_infected, range_sigma_h)
[init_cumu_infected, sigma_h] = meshgrid(range_init_cumu_infected, range_sigma_h);
how_many = numel(init_cumu_infected);
for i = 1:how_many
    params1 = param;
    params1.init_cumu_infected = init_cumu_infected(i);

    params1.sigma_h = sigma_h(i);

    z(i) = Q(params1);
    
end
z = reshape(z,size(init_cumu_infected));

contour(sigma_h,init_cumu_infected,z,40);
xlabel('sigma_h values');
ylabel('init cumulative infected values');
colorbar
end