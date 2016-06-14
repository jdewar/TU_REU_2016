function [ op_param, fval ] = optimizer(obj_fn, nonlincon, lb, ub, params)
%OPTIMIZER ...

names = fieldnames(params);

options = optimset('Algorithm','active-set'); % we think we like sqp, but we aren't sure.

init_parray = (ub+lb)/2; % this could be an input / randomized

[parray, fval] = fmincon(obj_fn, init_parray, [],[],[],[], lb, ub, nonlincon, options);

op_param = array2struct(parray, names); 

end

