function [Rinf] = Q_Rinf (params, out, t)
%CHIK_Q_CUMU_INFECT ...
% [time, out1] = output(t, out(1,:), params, []);

Rinf = calc_Reff(params, out(end,:));

end