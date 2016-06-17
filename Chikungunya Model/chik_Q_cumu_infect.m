function [cumu_inf] = chik_Q_cumu_infect (params, out, t, functions)
%CHIK_Q_CUMU_INFECT ...

chik_output(t, out, params, [], functions)

cumu_inf = out(end,5);

end