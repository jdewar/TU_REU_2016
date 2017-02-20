function [init] = get_init_conditions(params, t)
%CHIK_INIT_CONDITIONS Given tspan, return desired initial conditions

init = ...
    [params.H0 * params.theta1 - params.init_cumulative_infected,
    params.H0 * params.theta2 - params.init_cumulative_infected,
    params.init_cumulative_infected * params.theta1,
    params.init_cumulative_infected * params.theta2,
    0,
    0,
    params.init_cumulative_infected * params.theta1,
    params.init_cumulative_infected * params.theta2,
    params.K_v,
    0,
    0];
end