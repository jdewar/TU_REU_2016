function [ lambda_h, lambda_v] = math4910_calc_biting_rates(P, out)
N_h = out(end,1) + out(end,2) + out(end,3);
N_v = out(end,5)+ out(end,6) + out(end,7);
lambda_h = (P.sigma_v*P.sigma_h*P.beta_hv*N_v)/(P.sigma_v*N_v + P.sigma_h *N_h); 
lambda_v = (P.sigma_v*P.sigma_h*P.beta_vh*N_h)/(P.sigma_v*N_v + P.sigma_h *N_h); 
end

