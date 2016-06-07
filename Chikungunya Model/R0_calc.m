function [R0] = R0_calc(params)
zeta = (params(10)*params(9))/(params(10)* params(12) + params(9)*params(11));

R_vh = params(1) * params(11) * zeta * (params(8)/((params(7)+params(8))*params(7)));
R_hv = params(2) * params(12) * zeta * (params(5)/((params(4)+params(5))*(params(4) + params(3))));

R0 = sqrt(R_vh * R_hv);
end