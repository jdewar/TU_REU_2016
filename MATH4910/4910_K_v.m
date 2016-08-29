function K_v = chik_K_v(prop, max, time)
min = max*prop;
amp = (max-min)/2;
K_v = amp * sin(time * (2 * pi/365) - (pi/2)) + amp + min;

end

