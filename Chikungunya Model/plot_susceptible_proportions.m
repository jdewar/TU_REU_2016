function [] = plot_susceptible_proportions(param,data,array_names, t_in)
init_suscept_pop = param.H0;
count = 1;
for i = .1:.1:1
    param.H0 = init_suscept_pop*i;
    suscept_pop(count) = param.H0;
    vals(count) = chik_obj_fn(struct2array(param,array_names),data,param,array_names, t_in);
    count = count+1;
end

plot(suscept_pop, vals);
xlabel('susceptible population');
ylabel('objective function value');

end

