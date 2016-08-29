function [cumu_inf] = math4910_Q_cumu_infect (params, out, t, functions)
%CHIK_Q_CUMU_INFECT ...
[time, output] = math4910_output(t, out, params, [], functions);

cumu_inf = output(end,5);

end