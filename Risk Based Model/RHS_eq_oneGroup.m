function [ out ] = RHS_eq_oneGroup( time, init_conditions, parameters)
%RHS_eq takes in the time, initial conditions and parameters of the model
%and calculates the output of the ODE equations

out = zeros(size(init_conditions));
%% Host
S_h = init_conditions(1);
I_h = init_conditions(2);
R_h = init_conditions(3);
I_h_cumulative = init_conditions(4);

%% Vectors
S_v = init_conditions(5);
E_v = init_conditions(6);
I_v = init_conditions(7);

%% Equations
N_h = S_h + I_h + R_h;
N_v = S_v + E_v + I_v;

lambda_h = parameters.beta_h * (I_v/N_v) * (calc_b_T(parameters.sigma_h,parameters.sigma_v, init_conditions) * parameters.theta)/N_h;
lambda_v = parameters.beta_v * (I_h/N_h) * (calc_b_T(parameters.sigma_h,parameters.sigma_v, init_conditions)/N_v);
%host
out(1) = (parameters.mu_h*parameters.theta*parameters.H0) - (lambda_h * S_h) - (parameters.mu_h*S_h);
out(2) = (lambda_h * S_h) - (parameters.gamma_h + parameters.mu_h)*I_h;
out(3) = (parameters.gamma_h * I_h) - (parameters.mu_h * R_h);
out(4) = (lambda_h * S_h);
%vector
out(5) = (parameters.psi_v - (parameters.psi_v - parameters.mu_v)*(N_v/parameters.K_v))*N_v - (lambda_v*S_v) - (parameters.mu_v * S_v);
out(6) = (lambda_v* S_v) - (parameters.nu_v + parameters.mu_v) * E_v;
out(7) = (parameters.nu_v*E_v) - (parameters.mu_v * I_v);



end

