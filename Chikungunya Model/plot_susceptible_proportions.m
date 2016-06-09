function [] = plot_susceptible_proportions(param,data,array_names, t_in, lb, ub)
init_suscept_pop = param.H0;
count = 1;
for i = .1:.1:1
    param.H0 = init_suscept_pop*i;
    lb(11) = param.H0;
    ub(11) = param.H0;
    
    param  = optimizer(data,lb,ub, param, array_names, t_in);
    
    suscept_pop(count) = param.H0
    
    vals(count) = chik_obj_fn(struct2array(param,array_names),data,param,array_names, t_in);
    
    count = count+1;
end

plot((suscept_pop/init_suscept_pop) * 100, vals);
xlabel('susceptible population');
ylabel('objective function value');

end

