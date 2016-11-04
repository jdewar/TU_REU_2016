function R0 = calc_R0(P, init)
%CHIK_CALC_R0 Given params and t0, return what would be R_0 at t_0

R_h = (1/(P.gamma_h +P.mu_h)) * P.beta_h * calc_b_T * ((((P.theta1 * calc_b_T(P, init))/(P.H0 * P.theta1))*P.theta1) + (((P.theta2 * calc_b_T(P, init))/(P.H0 * P.theta2))*P.theta2));
%not including theta because all bites happen on pop 1
R_v = (1/(P.nu_v + P.mu_v))*(P.nu_v/P.mu_v) * P.beta_v *(calc_b_T(P, init)/(init(5)+init(6)+init(7)));

%R_h = (1/(P.gamma_h + P.mu_h)) * (P.beta_h) * (calc_b_T(P.sigma_h, P.sigma_v, init)) / (init(1) + init(2) + init(3));

R0 = sqrt(R_v * R_h);

end