function [] = derivatives_time(t1, init, parameters)

for i = 1:1:length(t1)
    [t, out] = output([0 i], init, parameters, []);
    out(1)
    out1 = RHS_eq_twoGroup(t, out, parameters);
end

end