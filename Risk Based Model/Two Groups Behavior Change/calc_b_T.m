function [ b_T,rho_h, rho_v ] = calc_b_T(P, init)
%c1 = get_init_conditions1(P);
%c2 = get_init_conditions2(P);

%biting rates desired for hosts and vectors
b_hw1 = P.theta1*(P.sigma_h1 * init(1) + P.sigma_h1 *P.pi1* init(2) + P.sigma_h1 * init(3));
b_hw2 = P.theta2*(P.sigma_h2 * init(1) + P.sigma_h2 *P.pi2 * init(2) + P.sigma_h2 * init(3));
b_hw = b_hw1+b_hw2;
b_vw = P.sigma_v * init(4) + P.sigma_v * init(5) + P.sigma_v * init(6);

%total bites
b_T = (b_hw * b_vw)/(b_hw + b_vw);
rho_h = b_hw/b_T;
rho_v = b_vw/b_T;
end

