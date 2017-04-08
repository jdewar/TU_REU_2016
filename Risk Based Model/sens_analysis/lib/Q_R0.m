function [R0] = Q_R0 (params, out, t)
%CHIK_Q_CUMU_INFECT ...
[time, out1] = output(t, out(1,:), params, []);

R0 = calc_R0(params, out1);

end