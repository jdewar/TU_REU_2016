function Reff = calc_Reff(P, conditions)
%CHIK_CALC_R0 Given params and t0, return what would be R_0 at t_0
%change code to use pis
%[P.H0, sum(init(1:3))]
Nh = conditions(1) + conditions(2) + conditions(3);
Nv = conditions(5)+conditions(6)+ conditions(7);
[b_t, rho_h, rho_v] = calc_b_T(P, conditions);
P_hs = rho_h* ((P.sigma_h1 * conditions(1) * P.theta1) + (P.sigma_h2 * conditions(1) * P.theta2))/ (b_t);
R_h1 = P.theta1* (1/(P.gamma_h + P.mu_h)) * (P.beta_h) * (b_t/Nv) * P_hs ;
R_h2 = P.theta2* (1/(P.gamma_h + P.mu_h)) * (P.beta_h) * (b_t/Nv) * P_hs ;
% (conditions(1)/N) = (S_h * theta1)/(Nh * theta1)
R_h = R_h1+R_h2;
R_v = (1/(P.nu_v + P.mu_v))*(P.nu_v/P.mu_v) * (P.beta_v) * b_t/Nh * (conditions(5)/Nv);
%R_h = (1/(P.gamma_h + P.mu_h)) * (P.beta_h) * (calc_b_T(P.sigma_h, P.sigma_v, init)) / (init(1) + init(2) + init(3));

Reff = sqrt(R_v * R_h);

end