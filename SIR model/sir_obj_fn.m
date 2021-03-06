
function [val] = sir_obj_fn(param_array,data,params,array_names, t_in, total_pop)

for i = 1:length(array_names)
    name = array_names{i}; 
    params.(name) = param_array(i);
end

R0 =  R0_calc(params);
c = 1.00001 - R0;

new_init = sir_init_conditions(params, t_in, total_pop);

[t,Y] = sir_balanceANDsolve(t_in, new_init, params); 

val = real_model_cmp(Y,data);

if c>0
     val = val * (1+c);
end

% val = val/total_pop;

end

