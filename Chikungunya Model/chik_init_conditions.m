function [init] = chik_init_conditions(param, t)
%CHIK_INIT_CONDITIONS Given tspan, return desired initial conditions

K_v = chik_K_v(param.min_K, param.max_K, t(1));

S_h = param.H0 - param.init_infected;

init = [...
    S_h; ...
    0; ...
    param.init_infected; ...
    0; ...
    param.init_infected; ...
    K_v; ...
    0; ...
    0; ...
    0];

end

