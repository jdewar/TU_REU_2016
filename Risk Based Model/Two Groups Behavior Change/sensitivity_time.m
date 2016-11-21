function [] = sensitivity_time(params, out1, t1)

figure()
for i = 1:1:length(t1)
 Q1 = @(params) Q_Reff(params, out1, [0 i]);
% Q2 = @(params) Q_Iend(params,out1, [0 i]);
% Q3 = @(params) Q_R0(params,out1,t1);

sensitivity_Iend_sigmah1 = chik_sensitivity_analysis(Q1, params, 'sigma_h1');
plot(i, sensitivity_Iend_sigmah1, '*')
hold on
end

end