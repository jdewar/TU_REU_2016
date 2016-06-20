function [cumu_inf] = sir_cumu_infect (params, t, total_pop)
init = sir_init_conditions(params, t, total_pop);

[t,out] = sir_output(t, init, params,[]);

cumu_inf = out(end,4);

end