function [val] = chik_obj_fn(param_array,data,param_base,array_names, t_in, init)
params = param_base;
for i = 1:length(array_names)
    name = array_names{i}; 
    params.(name) = param_array(i);
end
[t,Y] = chik_balanceANDsolve(t_in, init,params); 
val = chik_real_model_cmp(Y,data);

end