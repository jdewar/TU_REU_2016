function [cumu_inf] = chik_cumu_infect (params,out, t, init)

[t,out] = chik_output(t, init, params,[]);

cumu_inf = out(end,5);

end