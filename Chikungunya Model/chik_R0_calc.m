function [R0] = chik_R0_calc(params)
average_K_v = params.min_K;

zeta = (params.sigma_v*params.sigma_h)/(params.sigma_v* average_K_v + params.sigma_h*params.H0);

R_hv = params.beta_hv * params.H0 * zeta * (params.nu_v/((params.mu_v+params.nu_v)*params.mu_v));

R_vh = params.beta_vh* average_K_v * zeta * (params.nu_h/((params.mu_h+params.nu_h)*(params.mu_h + params.gamma_h)));

R0 = sqrt(R_vh * R_hv);
end