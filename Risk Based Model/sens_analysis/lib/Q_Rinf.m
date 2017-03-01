function [Rinf] = Q_Rinf (params, out, t)
%CHIK_Q_CUMU_INFECT ...
[time, out1] = output(t, out(end,:), params, []);

Rinf = calc_Reff(params, out1, time);

end