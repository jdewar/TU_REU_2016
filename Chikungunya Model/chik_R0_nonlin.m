function [c, ceq] = chik_R0_nonlin(param)
R0 = chik_R0_calc(param);
c = 1- R0;
ceq = [];

end