function [] = sir_plot_contour(Q,c_range, gamma_range, param)
[c,gamma] = meshgrid(c_range,gamma_range);
for i = 1:numel(c)
    params1 = param;
    params1.c = c(i);
    params1.gamma = gamma(i);
    z(i) = Q(params1);
end
z = reshape(z,size(c));

contour(c,gamma,z,linspace(0, 1, 10));
xlabel('C Values','fontsize',16);
ylabel('\gamma Values','fontsize',16);
title('Comparing C and \gamma to Objective Function Value','fontsize',18)
colorbar
end