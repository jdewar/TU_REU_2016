function [] = sir_plot_contour_j(Q,c_range, gamma_range, param)

[c,gamma] = meshgrid(c_range,gamma_range);

parfor i = 1:numel(c)
    params1 = param;
    params1.c = c(i);
    params1.gamma = gamma(i);
    z(i) = sqrt(Q(params1));
end
z = reshape(z,size(c));
contours = [.5 1 2 3 4 6 8 10 12 15 18 22 26 30 34];

contour(c,gamma,z,contours);

xlabel('c Values','fontsize',16);
ylabel('\gamma Values','fontsize',16);
title('Objective Function Values','fontsize',18)
colorbar
%colormap('cool')
end