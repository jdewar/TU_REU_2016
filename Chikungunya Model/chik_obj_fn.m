function val = chik_obj_fn(param_array, data, array_names, t_in, functions)

params = array2struct(param_array, array_names);

new_init = chik_init_conditions(params, t_in);

[~,Y] = chik_balanced_solve(t_in, new_init, params, functions); 

val = chik_cmp_real_model(Y, data);

end