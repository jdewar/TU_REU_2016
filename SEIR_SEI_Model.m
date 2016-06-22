function [] = SEIR_SEI_Model()
init = [100,0,10,0,1,1000,0,0,0];
tspan = 1:100;
param_struct = ...
    {'beta_hv', 0.24;
     'beta_vh', 0.24;
     'gamma_h', 1/6;
     'mu_h', 1/(70*365);
     'nu_h', 1/3;
     'psi_v', 0.3;
     'mu_v', 1/14;
     'nu_v', 1/11;
     'sigma_h', 19;
     'sigma_v', 0.5;
     'H0', 100;
     'K_v',1000;
    }';
params = struct(param_struct{:});
array_names = param_struct(1,:);

[t,out] = ode45(@(t,Y)rhs_seir_sei(t,Y,params), tspan, init);

subplot(1,2,1)
hold on
plot(t, out(:,1), 'g') 
plot(t, out(:,2), 'b') 
plot(t, out(:,3), 'r') 
plot(t, out(:,4), 'k')
legend('Exposed','Infected','Recovered', 'Cumulative Infected', 'Location', 'best')
hold off

xlabel('Time in Weeks', 'fontsize', 16)
ylabel('Human Population', 'fontsize', 16)
title('Human SEIR Dynamics', 'fontsize', 18)
subplot(1,2,2)
hold on
plot(t, out(:,6), 'g') 
plot(t, out(:,7), 'b')
plot(t, out(:,8), 'r')
legend('Susceptible','Exposed','Infected', 'Location', 'best')

xlabel('Time in Weeks', 'fontsize', 16)
ylabel('Mosquito Population','fontsize', 16)
title('Mosquito SEI dynamics', 'fontsize', 18)

end

function [out] = rhs_seir_sei(tspan,init,P)
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

out(1) = P.mu_h*P.H0 - lambda_h * sh - P.mu_h*sh;
out(2) = lambda_h*sh - (P.nu_h+P.mu_h)*eh;
out(3) = P.nu_h*eh - (P.gamma_h + P.mu_h)*ih;
out(4) = P.gamma_h*ih - P.mu_h*rh;
out(5) = P.nu_h*eh;

lambda_v = (P.sigma_v*P.sigma_h*P.beta_vh*N_h)/(P.sigma_v*N_v + P.sigma_h *N_h) * (ih/N_h); 

out(6) = (P.psi_v - (P.psi_v - P.mu_v)*(N_v/P.K_v))*N_v - lambda_v*sv - P.mu_v*sv;
out(7) = lambda_v*sv - (P.nu_v + P.mu_v)*ev;
out(8) = P.nu_v*ev - P.mu_v*iv;% Infected
out(9) = P.nu_v*ev;

end