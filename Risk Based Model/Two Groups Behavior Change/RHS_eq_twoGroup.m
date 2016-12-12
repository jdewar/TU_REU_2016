function [ out ] = RHS_eq_twoGroup( time, init_conditions, P)
%RHS_eq takes in the time, initial conditions and parameters of the model
%and calculates the output of the ODE equations

out = zeros([7 1]);
%% Host
%Group1 - Low Risk
S_h1 = init_conditions(1);
I_h1 = init_conditions(2);
R_h1 = init_conditions(3);
I_h_cumulative1 = init_conditions(4);
%Group2 - High Risk
S_h2 = init_conditions(1);
I_h2 = init_conditions(2);
R_h2 = init_conditions(3);
I_h_cumulative2 = init_conditions(4);

%% Vectors
S_v = init_conditions(5);
E_v = init_conditions(6);
I_v = init_conditions(7);

%% Equations
N_h1 = S_h1 + I_h1 + R_h1;
N_h2 = S_h2 + I_h2 + R_h2;
N_v = S_v + E_v + I_v;
[b_t, rho_h, rho_v ] = calc_b_T(P, init_conditions);
lambda_h1 = P.beta_h * (I_v/N_v) * (b_t*P.theta1)/N_h1;
lambda_h2 = P.beta_h * (I_v/N_v) * (b_t*P.theta2)/N_h2;

%host1
Y(1) = (P.mu_h*(P.theta1*P.H0)) - (lambda_h1 * S_h1) - (P.mu_h*S_h1);
Y(2) = (lambda_h1 * S_h1) - (P.gamma_h + P.mu_h)*I_h1;
Y(3) = (P.gamma_h * I_h1) - (P.mu_h * R_h1);
Y(4) = (lambda_h1 * S_h1);

%host2
Y(5) = (P.mu_h*(P.theta2*P.H0)) - (lambda_h2 * S_h2) - (P.mu_h*S_h2);
Y(6) = (lambda_h2 * S_h2) - (P.gamma_h + P.mu_h)*I_h2;
Y(7) = (P.gamma_h * I_h2) - (P.mu_h * R_h2);
Y(8) = (lambda_h2 * S_h2);

%probability a host is infected
% totalBites1 = rho_h*(S_h1*P.sigma_h1 + I_h1*P.pi1*P.sigma_h1 + R_h1*P.sigma_h1);
% totalBites2 = rho_h*(S_h2*P.sigma_h2 + I_h2*P.pi2*P.sigma_h2 + R_h2*P.sigma_h2);
P_HI = (rho_h*(P.sigma_h1*I_h1 + P.sigma_h2*I_h2))/(b_t);
lambda_v = P.beta_v * P_HI * (b_t/N_v);

%vector
Y(9) = (P.psi_v - (P.psi_v - P.mu_v)*(N_v/P.K_v))*N_v - (lambda_v*S_v) - (P.mu_v * S_v);
Y(10) = (lambda_v* S_v) - (P.nu_v + P.mu_v) * E_v;
Y(11) = (P.nu_v*E_v) - (P.mu_v * I_v);

out(1) = Y(1) + Y(5); %total susceptible host
out(2) = Y(2) + Y(6); %total infected host
out(3) = Y(3) + Y(7); %total recovered host
out(4) = Y(4) + Y(8); %total cumulative infected host
out(5) = Y(9); %susceptible vector
out(6) = Y(10); %exposed vector
out(7) = Y(11); %infected vector

end

