function [c, ceq] = chik_nonlincon_R0(param, names, functions, t0)
%CHIK_NONLINCON_R0 Return fmincon's nonlinear constraint.  Curry t0.

R0 = chik_calc_R0(array2struct(param, names), functions, t0);
c = 1.05 - R0; % may need to be above 1, to deal w/ fix t_balance in _balanced_solve
ceq = [];

end