function [ op_param] = optimizer(real_data,lb,ub, param, array_names, t)

fn = @(x)chik_obj_fn(x,real_data,param,array_names,t);

nonlincon = @(x)chik_R0_nonlin(x);

options = optimset('Algorithm','sqp');

[x] = fmincon(fn, (ub+lb)/2, [],[],[],[],lb,ub,nonlincon,options);

op_param = array2struct(param, x, array_names); 

end

