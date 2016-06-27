function [] = plot_sensitivities(sensitivity_H0, sensitivity_sigma_h, sensitivity_max_K)
figure()
plot(sensitivity_H0)
ylabel('Sensitivity of H0')
xlabel('End week used for predictions')

figure()
plot(sensitivity_sigma_h)
ylabel('Sensitivity of sigma_h')
xlabel('End week used for predictions')

figure()
plot(sensitivity_max_K)
ylabel('Sensitivity of max_K')
xlabel('End week used for predictions')

end

