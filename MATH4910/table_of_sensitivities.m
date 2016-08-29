function [sensitivity_table] = table_of_sensitivities(params,functions, firstWeek2014, full_count,tspan_full_count, array_names, lb, ub)

c = 1;

for i = 10:10:40
    real1 = full_count(1:i);
    tend = length(real1);
    tspan_predictions = [(firstWeek2014*7):7:((tend+firstWeek2014-1)*7)];
    
    obj_fn1 = @(parray)4910_obj_fn(parray, real1, array_names, tspan_predictions, functions);
    opt_params1 = optimizer(obj_fn1, lb, ub, params);
    
    init = chik_init_conditions(opt_params1, tspan_full_count);
    [t,out] = chik_balanced_solve(tspan_full_count, init, opt_params1, functions);
    
    Q1 = @(opt_params1)chik_Q_cumu_infect (opt_params1, out, t, functions);
    weeks(c) = i;
    H0_values(c) = opt_params1.H0;
    sigma_h_values(c) = opt_params1.sigma_h;
    max_K_values(c) = opt_params1.max_K;
    [sensitivity_H0(c), H0_Q_vals(c)]  = chik_sensitivity_analysis(Q1,opt_params1,'H0');
    [sensitivity_sigma_h(c), sigma_h_Q_vals(c)]  = chik_sensitivity_analysis(Q1,opt_params1,'sigma_h');
    [sensitivity_max_K(c), max_K_Q_vals(c)]  = chik_sensitivity_analysis(Q1,opt_params1,'max_K');
    c = c+1;
end

sensitivity_table = table(weeks', sensitivity_H0',H0_Q_vals', H0_values', sensitivity_sigma_h',sigma_h_Q_vals', sigma_h_values', sensitivity_max_K',max_K_Q_vals', max_K_values','VariableNames', {'weeks','sensitivity_H0','H0_Q_vals','H0_values', 'sensitivity_sigma_h','sigma_h_Q_vals','sigma_h_values', 'sensitivity_max_K','max_K_Q_vals', 'max_K_values'});
plot_sensitivities(sensitivity_H0, sensitivity_sigma_h, sensitivity_max_K)

end

