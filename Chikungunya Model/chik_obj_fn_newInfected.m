function [val] = chik_obj_fn_newInfected(param_array,data,param_base,array_names, t_in, functions)
params = param_base;
for i = 1:length(array_names)
    name = array_names{i}; 
    params.(name) = param_array(i);
end

new_init = get_init_conditions(params, t_in);

[t,Y] = chik_balanceANDsolve(t_in, new_init, params, functions); 

val = chik_cmp_newInfected(Y,data);

end