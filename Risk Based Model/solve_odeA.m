function [T, Y] = solve_odeA(params)

% This function runs the MATLAB ode solver given an initial guess and range of time,
%  and returns the output of the ode solver
% If you need to do preprocessing before each run, such as solve the system to steady-state first
%  this would be where that can take place.
%dydt_fn = @(t,Y, params) RHS_eq_twoGroup(t, Y, params);
dydt_fn = calc_area(params);

options = odeset();
[T, Y] = ode45(dydt_fn, [1:10], [2,3], []);

end