function Reff = calc_Reff(P, conditions)
%CHIK_CALC_R0 Given params and t0, return what would be R_0 at t_0
%change code to use pis
%[P.H0, sum(init(1:3))]
Nh = conditions(1) + conditions(2) + conditions(3);
Nv = conditions(5)+conditions(6)+ conditions(7);

R_h = (1/(P.gamma_h + P.mu_h)) * (P.beta_h) * (calc_b_T(P, conditions)/Nv) * (conditions(1)/Nh) ;
% (conditions(1)/N) = (S_h * theta1)/(Nh * theta1)

R_v = (1/(P.nu_v + P.mu_v))*(P.nu_v/P.mu_v) * (P.beta_v) *(P.pi1+P.pi2)* (calc_b_T(P, conditions)/Nh) * (conditions(5)/Nv);
%R_h = (1/(P.gamma_h + P.mu_h)) * (P.beta_h) * (calc_b_T(P.sigma_h, P.sigma_v, init)) / (init(1) + init(2) + init(3));

Reff = sqrt(R_v * R_h);

end