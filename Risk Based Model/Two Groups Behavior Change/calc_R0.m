function R0 = calc_R0(P, init)
%CHIK_CALC_R0 Given params and t0, return what would be R_0 at t_0
[b_t, rho_h, rho_v] = calc_b_T(P, init);
%[P.H0, sum(init(1:3))]
N = (init(1) + init(2) + init(3));
R_h = (1/(P.gamma_h +P.mu_h)) * P.beta_h * (b_t/N) * (P.theta1 + P.theta2);
%not including theta because all bites happen on pop 1
R_v = (1/(P.nu_v + P.mu_v))*(P.nu_v/P.mu_v) * P.beta_v *(b_t/(init(5)+init(6)+init(7)));

R0 = sqrt(R_v * R_h);

end