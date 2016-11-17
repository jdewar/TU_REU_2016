function [T, Y] = solve_ode(trange, x0, params)

% This function runs the MATLAB ode solver given an initial guess and range of time,
%  and returns the output of the ode solver
% If you need to do preprocessing before each run, such as solve the system to steady-state first
%  this would be where that can take place.

dydt_fn = make_ode(params);

options = odeset();
[T, Y] = ode45(dydt_fn, trange, x0, options);

end
