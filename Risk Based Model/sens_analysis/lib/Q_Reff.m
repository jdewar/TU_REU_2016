function [Reff] = Q_Reff (params, out, t)
%CHIK_Q_CUMU_INFECT ...
[time, out1] = output(t, out(1,:), params, []);

Reff = calc_Reff(params, out1, time);

end