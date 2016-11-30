function [ out ] = RHS_eq_twoGroup( time, init_conditions, parameters)
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

lambda_h1 = parameters.beta_h * (I_v/N_v) * (calc_b_T(parameters, init_conditions)*parameters.theta1)/N_h1;
lambda_h2 = parameters.beta_h * (I_v/N_v) * (calc_b_T(parameters, init_conditions)*parameters.theta2)/N_h2;

%host1
Y(1) = (parameters.mu_h*(parameters.theta1*parameters.H0)) - (lambda_h1 * S_h1) - (parameters.mu_h*S_h1);
Y(2) = (lambda_h1 * S_h1) - (parameters.gamma_h + parameters.mu_h)*I_h1;
Y(3) = (parameters.gamma_h * I_h1) - (parameters.mu_h * R_h1);
Y(4) = (lambda_h1 * S_h1);

%host2
Y(5) = (parameters.mu_h*(parameters.theta2*parameters.H0)) - (lambda_h2 * S_h2) - (parameters.mu_h*S_h2);
Y(6) = (lambda_h2 * S_h2) - (parameters.gamma_h + parameters.mu_h)*I_h2;
Y(7) = (parameters.gamma_h * I_h2) - (parameters.mu_h * R_h2);
Y(8) = (lambda_h2 * S_h2);

%probability a host is infected
P_HI = (parameters.pi1*I_h1 + parameters.pi2*I_h2)/(parameters.H0 * (parameters.theta1 + parameters.theta2));
lambda_v = parameters.beta_v * P_HI * (calc_b_T(parameters, init_conditions)/N_v);

%vector
Y(9) = (parameters.psi_v - (parameters.psi_v - parameters.mu_v)*(N_v/parameters.K_v))*N_v - (lambda_v*S_v) - (parameters.mu_v * S_v);
Y(10) = (lambda_v* S_v) - (parameters.nu_v + parameters.mu_v) * E_v;
Y(11) = (parameters.nu_v*E_v) - (parameters.mu_v * I_v);

out(1) = Y(1) + Y(5); %total susceptible host
out(2) = Y(2) + Y(6); %total infected host
out(3) = Y(3) + Y(7); %total recovered host
out(4) = Y(4) + Y(8); %total cumulative infected host
out(5) = Y(9); %susceptible vector
out(6) = Y(10); %exposed vector
out(7) = Y(11); %infected vector

end

