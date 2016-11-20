function [Reff] = Q_Reff (params, out, t)
%CHIK_Q_CUMU_INFECT ...
[time, out1] = output(t, out(end,:), params, []);

Reff = calc_Reff(params, out1);

end