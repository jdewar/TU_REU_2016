function R0 = math4910_calc_R0(P, functions, t0)
%CHIK_CALC_R0 Given params and t0, return what would be R_0 at t_0

K_v = math4910_calc_K_v(P, functions, t0);

zeta = (P.sigma_v * P.sigma_h) / (P.sigma_v * K_v + P.sigma_h * P.H0);

R_hv = P.beta_hv * P.H0 * zeta * (P.nu_v / ((P.mu_v + P.nu_v) * P.mu_v));

R_vh = P.beta_vh * K_v * zeta * (P.nu_h / ((P.mu_h + P.nu_h) * (P.mu_h + P.gamma_h)));

R0 = sqrt(R_vh * R_hv);

end