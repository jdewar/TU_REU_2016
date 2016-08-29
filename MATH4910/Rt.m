function [r] = Rt(r0,r_inf)
r  = 1 - r_inf - exp(-r0 * r_inf);

end

