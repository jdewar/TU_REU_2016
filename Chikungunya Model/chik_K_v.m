function [ K_v] = chik_K_v(min, max, time)

    K_v = ((max-min)/2)*sin(time/365 * 2* pi - (pi/2)) + ((max-min)/2) + min;

end

