function Q = bbb(pbase)

% This function is the 'blackbox' that takes the parameters and returns the quantities we
%  want to test for sensitivity. This is where you define what the quantities of interest are.
% P and Q can be arrays or structs, but it is best to pass all parameters/quantities in one variable.


P.beta_h = 0.24;
P.beta_v  = 0.24;
P.gamma_h  = 1/6;
P.mu_h  = 1/(70*365);
P.nu_h  = 1/3;
P.psi_v  = 0.3;
P.mu_v  = 1/14;
P.nu_v  = 1/11;
P.sigma_h1  = pbase.sigma_h1;
P.sigma_h2  = pbase.sigma_h2;
P.sigma_v  = 0.5;
P.H0  = 1000000;
P.theta1  = pbase.theta1;
P.theta2  = pbase.theta1;
P.init_cumulative_infected  = pbase.init_cumulative_infected;
P.K_v  = pbase.K_v;
P.pi1  = pbase.pi1;
P.pi2  = pbase.pi2;

[T, Y] = solve_ode([1:50], [490000,10,0,10,1000000,0,0], P);

%create R0,Reff @ time in middle?, and max_inf
%use event to get time when some % infected
Q.R0 = Q_R0(P, Y, T);
Q.cumulative_infected = Y(end,4);

end
