function [] = derivatives_time(t1, init, parameters)

for i = 1:500
    [t, out] = output(t1, init, parameters, []);
    y = out(end,:);
    out1 = RHS_eq_twoGroup(t, y, parameters)
end
figure()
plot(t1, out1(:,1), 'g');

end