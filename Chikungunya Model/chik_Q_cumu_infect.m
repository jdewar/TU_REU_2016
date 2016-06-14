function [cumu_inf] = chik_Q_cumu_infect (params, out, t, init)
%CHIK_Q_CUMU_INFECT ...

[~,out] = chik_output(t, init, params,[]);

cumu_inf = out(end,5);

end