function [cumu_inf] = chik_Q_cumu_infect (params, out, t, functions)
%CHIK_Q_CUMU_INFECT ...
[time, output] = chik_output(t, out, params, [], functions);

cumu_inf = output(end,5);

end