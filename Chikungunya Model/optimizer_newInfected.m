function [op_param] = optimizer_newInfected(real_data,lb,ub, param, array_names, t, functions)

fn = @(x)chik_obj_fn_newInfected(x,real_data,param,array_names,t, functions);
               
 
nonlincon = @(x)chik_R0_nonlin(param);
 
options = optimset('Algorithm','sqp');
 
[x] = fmincon(fn, (ub+lb)/2, [],[],[],[],lb,ub,nonlincon,options);
 
op_param = array2struct(param, x, array_names); 

end