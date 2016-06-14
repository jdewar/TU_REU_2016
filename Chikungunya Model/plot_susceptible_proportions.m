function [] = plot_susceptible_proportions(params, data, t_in, lb, ub, functions)
init_suscept_pop = params.H0;
count = 1;

names = fieldnames(params);

range = .1:.1:1;

suscept_pop = NaN(size(range));
vals = NaN(size(range));
for i = range
    params.H0 = init_suscept_pop*i;
    lb(11) = params.H0;
    ub(11) = params.H0;

    obj_fn = @(parray) chik_obj_fn(parray, data, names, t_in, functions);
    nonlincon = @(x) chik_nonlincon_R0(x, names, functions, t_in(1));

    % obj_fn, nonlincon, lb, ub, params
    params  = optimizer(obj_fn, nonlincon, lb, ub, params);
    
    suscept_pop(count) = params.H0
    
    parray = struct2array(params, names);
    vals(count) = chik_obj_fn(parray, data, names, t_in, functions);
    
    count = count+1;
end

plot((suscept_pop/init_suscept_pop) * 100, vals);
xlabel('susceptible population');
ylabel('objective function value');

end

