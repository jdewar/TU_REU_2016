function [ b_T ] = calc_b_T(sigma_h, sigma_v, pops)
b_hw = sigma_h * pops(1) + sigma_h * pops(2) + sigma_h * pops(3);
b_vw = sigma_v * pops(4) + sigma_v * pops(5) + sigma_v * pops(6);

b_T = (b_hw * b_vw)/(b_hw + b_vw);

end

