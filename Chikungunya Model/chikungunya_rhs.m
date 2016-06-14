function [ out] = chikungunya_rhs( t, init, P, F)
% sir_rhs defines the ode for a simple SIR model
% Parameters are set
    %Input P:
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
lambda_h = (P.sigma_v*P.sigma_h*P.beta_hv*N_v)/(P.sigma_v*N_v + P.sigma_h *N_h) * (iv/N_v); 

out(1) = P.mu_h*P.H0 - lambda_h * sh - P.mu_h*sh;% Susceptible
out(2) = lambda_h*sh - (P.nu_h+P.mu_h)*eh;
out(3) = P.nu_h*eh - (P.gamma_h + P.mu_h)*ih;% Infected
out(4) = P.gamma_h*ih - P.mu_h*rh;
out(5) = P.nu_h*eh;

lambda_v = (P.sigma_v*P.sigma_h*P.beta_vh*N_h)/(P.sigma_v*N_v + P.sigma_h *N_h) * (ih/N_h); 
K_v = F.K_v(P.min_K,P.max_K,t);

out(6) = (P.psi_v - (P.psi_v - P.mu_v)*(N_v/K_v))*N_v - lambda_v*sv - P.mu_v*sv;% Susceptible
out(7) = lambda_v*sv - (P.nu_v + P.mu_v)*ev;
out(8) = P.nu_v*ev - P.mu_v*iv;% Infected
out(9) = P.nu_v*ev;

end

