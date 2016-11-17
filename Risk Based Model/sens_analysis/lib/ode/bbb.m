function Q = bbb(P)

% This function is the 'blackbox' that takes the parameters and returns the quantities we
%  want to test for sensitivity. This is where you define what the quantities of interest are.
% P and Q can be arrays or structs, but it is best to pass all parameters/quantities in one variable.

[T, Y] = solve_ode(0:10, [.1 .1 .1], P);

Q.num_recovered = Y(end,3);
Q.max_infected = max(Y(:,2));

end
