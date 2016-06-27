function [ op_param, fval ] = optimizer(obj_fn, lb, ub, params)
%OPTIMIZER ...

names = fieldnames(params);

options = optimset('Algorithm','active-set'); % we think we like sqp, but we aren't sure.

init_parray = (ub+lb)/6; % this could be an input / randomized

[parray, fval] = fmincon(obj_fn, init_parray, [],[],[],[], lb, ub, [], options);

op_param = array2struct(parray, names); 

end

