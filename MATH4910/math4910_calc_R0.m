function R0 = math4910_calc_R0(P, functions, t0)
%CHIK_CALC_R0 Given params and t0, return what would be R_0 at t_0

K_v = math4910_calc_K_v(P, functions, t0);

R_hv = (P.sigma_v * P.sigma_h * P.beta_hv * P.H0) / ((P.sigma_v * K_v + P.sigma_h * P.H0) * (P.gamma_h + P.mu_h));

R_vh = (P.sigma_v * P.sigma_h * P.beta_hv * P.H0) / (P.mu_v * (P.sigma_v * K_v + P.sigma_h * P.H0));

R0 = sqrt(R_vh * R_hv);

end