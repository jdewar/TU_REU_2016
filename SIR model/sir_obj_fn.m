function [val] = sir_obj_fn(param_array, data, array_names, t_in, init)
%params = param_base;
for i = 1:length(array_names)
    name = array_names{i}; 
    params.(name) = param_array(i);
end
[t,Y] = sir_balanceANDsolve(t_in, init,params); 
val = real_model_cmp(Y,data);

end

