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
P.sigma_h1  = 5;
P.sigma_h2  = 25;
P.sigma_v  = 0.5;
P.H0  = 466000;
P.theta0  = 0.8;
P.theta2  = pbase.theta2;
P.theta1  = 1 - P.theta2;
P.init_cumulative_infected  = 10;
P.K_v  = 932000;
P.pi1  = 0.1;
P.pi2  = 0.6919;
P.H0 = P.H0 * (1 - P.theta0);

[T, Y] = solve_ode([1:200], [490000* P.theta1,490000* P.theta2, 10* P.theta1, 10* P.theta2,0,0,10* P.theta1, 10* P.theta2,1000000,0,0], P);

%create R0,Reff @ time in middle?, and max_inf
%use event to get time when some % infected
Q.R0 = Q_R0(P, Y, T);
Q.Reff = Q_Reff(P, Y, T);
Q.cumulative_infected = Y(end,4);
Q.Rinf = Q_Rinf(P, Y, T);

end
