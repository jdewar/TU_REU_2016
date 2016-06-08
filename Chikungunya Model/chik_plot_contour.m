function [] = chik_plot_contour(Q,range_gamma_h, range_sigma_h, param)
[gamma_h, sigma_h] = meshgrid(range_gamma_h, range_sigma_h);
for i = 1:numel(gamma_h)
    params1 = param;
%     params1.beta_hv = beta_hv(i);
%     params1.beta_vh = beta_vh(i);
    params1.gamma_h = gamma_h(i);
%     params1.mu_h = mu_h(i);
%     params1.nu_h = nu_h(i);
%     params1.psi_v = psi_v(i);
%     params1.mu_v = mu_v(i);
%     params1.nu_v = nu_v(i);
    params1.sigma_h = sigma_h(i);
%     params1. sigma_v =  sigma_v(i);
%     params1. H0 =  H0(i);
%     params1. K_v =  K_v(i);
    z(i) = Q(params1);
end
z = reshape(z,size(gamma_h));

contour(sigma_h,gamma_h,z,40);
xlabel('sigma_h values');
ylabel('gamma_h values');
colorbar
end