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
P.mu_v  = 1/17;
P.nu_v  = 1/11;
P.sigma_h1  = 5;
P.sigma_h2  = 30;
P.sigma_v  = 0.5;
P.H0  = 466000;
P.theta0  = 0.8;
P.theta2  = pbase.theta2;
P.theta1  = 1 - P.theta2;
P.init_cumulative_infected  = 76;
P.K_v  = 932000;
P.pi1  = 0.1;
P.pi2  = 0.6538;
P.H0 = P.H0 * (1 - P.theta0);

init = ...
    [P.H0 * P.theta1 - P.init_cumulative_infected*P.theta1,
    P.H0 * P.theta2 - P.init_cumulative_infected*P.theta2,
    P.init_cumulative_infected * P.theta1,
    P.init_cumulative_infected * P.theta2,
    0,
    0,
    P.init_cumulative_infected * P.theta1,
    P.init_cumulative_infected * P.theta2,
    P.K_v,
    0,
    0];

init1 = get_init_conditions(P, 0);
[T,Y] = balance_and_solve(0:300, init1, P);

%create R0,Reff @ time in middle?, and max_inf
%use event to get time when some % infected

Q.R0 = Q_R0(P, Y);
Q.Reff = Q_Reff(P, Y);
Q.cumulative_infected = Y(end,7) + Y(end,8);
Q.Rinf = Q_Rinf(P, Y);
%[Q.R0 Q.Reff Q.Rinf]
end
