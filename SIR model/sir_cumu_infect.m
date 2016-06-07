function[cumu_inf] = sir_cumu_infect (params,out, t, init)

out = sir_output(t, init, params);
cumu_inf = out(end,4);

end