function vals = endemic_eq()
c = 1;
for i = linspace(1,5,20)
    r0(c) = i;
    rinf = .8;
    x0 = rinf;
    vals(c) = fzero(@(r_inf)Rt(r0(c),r_inf),x0)
    c = c+1;
end
vals(1) = 0;
plot(r0,vals)
xlim([0,5]);
xlabel('R_0', 'fontsize', 16)
ylabel('R(inf)', 'fontsize', 16)
title('Endemic Equilibrium for Recovered Population', 'fontsize', 18)

end