function [init] = math4910_init_conditions(param, t)
%CHIK_INIT_CONDITIONS Given tspan, return desired initial conditions

K_v = math4910_K_v(param.prop_K, param.max_K, t(1));

S_h = param.H0 - param.init_cumu_infected;

init = [...
    S_h; ...
    param.init_cumu_infected; ...
    0; ...
    param.init_cumu_infected; ...
    K_v; ...
    0; ...
    0];

end

