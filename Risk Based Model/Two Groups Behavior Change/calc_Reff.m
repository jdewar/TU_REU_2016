function Reff = calc_Reff(P, init, conditions)
%CHIK_CALC_R0 Given params and t0, return what would be R_0 at t_0

%[P.H0, sum(init(1:3))]
N = (conditions(1) + conditions(2) + conditions(3));
R_eh1 = P.theta1 * (1/(P.gamma_h +P.mu_h)) * P.beta_h * (conditions(1)/N) * (((P.theta1 * calc_b_T(P, init))/(N * P.theta1))*P.theta1);
R_eh2 = P.theta2 * (1/(P.gamma_h +P.mu_h)) * P.beta_h * (conditions(1)/N) * (((P.theta2 * calc_b_T(P, init))/(N * P.theta2))*P.theta2);
R_h = R_eh1+R_eh2
% (conditions(1)/N) = (S_h * theta1)/(Nh * theta1)
Nv = conditions(5)+conditions(6)+ conditions(7);
R_v = (1/(P.nu_v + P.mu_v))*(P.nu_v/P.mu_v) * P.beta_v * conditions(5)/Nv *(calc_b_T(P, init)/(Nv));

%R_h = (1/(P.gamma_h + P.mu_h)) * (P.beta_h) * (calc_b_T(P.sigma_h, P.sigma_v, init)) / (init(1) + init(2) + init(3));

R0 = sqrt(R_v * R_h);

end