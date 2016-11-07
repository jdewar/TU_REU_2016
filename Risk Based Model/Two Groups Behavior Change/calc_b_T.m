function [ b_T ] = calc_b_T(P, init)
c1 = get_init_conditions1(P);
c2 = get_init_conditions2(P);

%biting rates desired for hosts and vectors
b_hw1 = P.sigma_h1 * c1(1) + P.sigma_h1 * P.pi1 * c1(2) + P.sigma_h1 * c1(3);
b_hw2 = P.sigma_h2 * c2(1) + P.sigma_h2 * P.pi2 * c2(2) + P.sigma_h2 * c2(3);
b_hw = b_hw1+b_hw2;
b_vw = P.sigma_v * init(4) + P.sigma_v * init(5) + P.sigma_v * init(6);

%total bites
b_T = (b_hw * b_vw)/(b_hw + b_vw);

end

