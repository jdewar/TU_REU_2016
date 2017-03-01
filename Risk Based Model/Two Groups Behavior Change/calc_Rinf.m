function Rinf = calc_Rinf(P, init, time)
%CHIK_CALC_R0 Given params and t0, return what would be R_0 at t_0
t = length(time);

Nh = init(t,1) + init(t,2) + init(t,3) + init(t,4) + init(t,5) + init(t,6);
Nv = init(t,9) + init(t,10) + init(t,11);

[b_t, rho_h, rho_v] = calc_b_T(P, init);
P_hs1 = (rho_h * P.sigma_h1 * init(t,1))/b_t;
P_hs2 = (rho_h * P.sigma_h2 * init(t,2))/b_t;
P_hs = P_hs1 + P_hs2;

R_h1 = P.theta1 * (1/(P.gamma_h + P.mu_h)) * (P.beta_h) * (b_t/Nv) * P_hs ;
R_h2 = P.theta2 * (1/(P.gamma_h + P.mu_h)) * (P.beta_h) * (b_t/Nv) * P_hs ;
R_h = R_h1+R_h2;

R_v = (1/(P.nu_v + P.mu_v)) * (P.nu_v/P.mu_v) * (P.beta_v) * (b_t/Nh) * (init(t,9)/Nv);

Rinf = sqrt(R_v * R_h);

end