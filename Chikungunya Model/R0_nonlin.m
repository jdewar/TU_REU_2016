function [c, ceq] = R0_nonlin(params)
R0 = R0_calc(params);
c = 1- R0;
ceq = [];

end