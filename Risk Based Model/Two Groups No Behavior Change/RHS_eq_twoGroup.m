function [ out ] = RHS_eq_twoGroup( time, init_conditions, parameters)
%RHS_eq takes in the time, initial conditions and parameters of the model
%and calculates the output of the ODE equations

out = zeros(11);
%% Host
%Group1
init_conditions1 = get_init_conditions1(parameters, time);
S_h1 = init_conditions1(1);
I_h1 = init_conditions1(2);
R_h1 = init_conditions1(3);
I_h_cumulative1 = init_conditions1(4);
%Group2
init_conditions2 = get_init_conditions2(parameters, time);
S_h2 = init_conditions2(1);
I_h2 = init_conditions2(2);
R_h2 = init_conditions2(3);
I_h_cumulative2 = init_conditions2(4);

%% Vectors
S_v = init_conditions(5);
E_v = init_conditions(6);
I_v = init_conditions(7);

%% Equations
N_h1 = parameters.theta1 * parameters.H0;
N_h2 = parameters.theta1 * parameters.H0;
N_v = S_v + E_v + I_v;

lambda_h1 = parameters.beta_h * (I_v/N_v) * (calc_b_T(parameters, init_conditions)*parameters.theta1)/N_h1;
lambda_h2 = parameters.beta_h * (I_v/N_v) * (calc_b_T(parameters, init_conditions)*parameters.theta2)/N_h2;

%host1
out(1) = (parameters.mu_h*(parameters.theta1*parameters.H0)) - (lambda_h1 * S_h1) - (parameters.mu_h*S_h1);
out(2) = (lambda_h1 * S_h1) - (parameters.gamma_h + parameters.mu_h)*I_h1;
out(3) = (parameters.gamma_h * I_h1) - (parameters.mu_h * R_h1);
out(4) = (lambda_h1 * S_h1);

%host2
out(5) = (parameters.mu_h*(parameters.theta2*parameters.H0)) - (lambda_h2 * S_h2) - (parameters.mu_h*S_h2);
out(6) = (lambda_h2 * S_h2) - (parameters.gamma_h + parameters.mu_h)*I_h2;
out(7) = (parameters.gamma_h * I_h2) - (parameters.mu_h * R_h2);
out(8) = (lambda_h2 * S_h2);

P_HI = (I_h1 + I_h2)/(parameters.H0);
lambda_v = parameters.beta_v * P_HI * (calc_b_T(parameters, init_conditions)/N_v);
%vector
out(9) = (parameters.psi_v - (parameters.psi_v - parameters.mu_v)*(N_v/parameters.K_v))*N_v - (lambda_v*S_v) - (parameters.mu_v * S_v);
out(10) = (lambda_v* S_v) - (parameters.nu_v + parameters.mu_v) * E_v;
out(11) = (parameters.nu_v*E_v) - (parameters.mu_v * I_v);



end

