function val = chik_obj_fn(param_array, data, array_names, t_in, functions)
%chik_obj_fn returns the value that the objective function optimizes over

params = array2struct(param_array, array_names);

c = 1.00001 - chik_calc_R0(params, functions, t_in(1));

new_init = chik_init_conditions(params, t_in);

[~,Y] = chik_balanced_solve(t_in, new_init, params, functions); 
 val = chik_cmp_recent(Y, data);

 
%forces optimizer to run over smooth curve when R0 < 1.5 by multiplying by 
%the distance from minimum R0 
if c>0
     val = val * (1+c);
  
end

end