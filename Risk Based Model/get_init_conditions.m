function [init] = get_init_conditions(param, t)
%CHIK_INIT_CONDITIONS Given tspan, return desired initial conditions

S_h = param.H0 - param.init_cumulative_infected;

init = [...
    S_h; ...
    param.init_cumulative_infected; ...
    0; ...
    param.init_cumulative_infected; ...
    param.K_v; ...
    0; ...
    0];

end