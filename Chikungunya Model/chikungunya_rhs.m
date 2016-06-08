function [ out] = chikungunya_rhs( t, init, param)
% sir_rhs defines the ode for a simple SIR model
% parameters are set
    %Input param:
        %t is time
        %init is initial conditions column vector
        %beta  is probability of transmission
        %c is contact rate
    %Output:
        %out is the suceptible and infected array

out = zeros(size(init));
sh = init(1);
eh = init(2);
ih = init(3);
rh = init(4);
cumulative_ih = init(5);
%% Vectors
sv = init(6);
ev = init(7);
iv = init(8);
cumulative_iv = init(9);

%% Calculations
N_h = sh+eh+ih+rh;
N_v = sv+ev+iv;
lambda_h = (param.sigma_v*param.sigma_h*param.beta_hv*N_v)/(param.sigma_v*N_v + param.sigma_h *N_h) * (iv/N_v); 

out(1) = param.mu_h*param.H0 - lambda_h * sh - param.mu_h*sh;% Susceptible
out(2) = lambda_h*sh - (param.nu_h+param.mu_h)*eh;
out(3) = param.nu_h*eh - (param.gamma_h + param.mu_h)*ih; %Infected
out(4) = param.gamma_h*ih - param.mu_h*rh;
out(5) = param.nu_h*eh;

lambda_v = (param.sigma_v*param.sigma_h*param.beta_vh*N_h)/(param.sigma_v*N_v + param.sigma_h *N_h) * (ih/N_h); 

out(6) = (param.psi_v - (param.psi_v - param.mu_v)*(N_v/param.K_v))*N_v - lambda_v*sv - param.mu_v*sv;% Susceptible
out(7) = lambda_v*sv - (param.nu_v + param.mu_v)*ev;
out(8) = param.nu_v*ev - param.mu_v*iv; %Infected
out(9) = param.nu_v*ev;

end

