function K_v = chik_K_v(min, max, time)

half_amp = (max-min)/2;

K_v = half_amp * sin(time * (2 * pi/365) - (pi/2)) + half_amp + min;

end

