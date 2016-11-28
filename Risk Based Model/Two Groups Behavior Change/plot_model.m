function [] = plot_model(t,Y)
%Plot_sir_model
%   takes time span, t, and solved sir matrix, Y, and graphs

subplot(1,2,1)
hold on
plot(t, Y(:,1), 'g', 'linewidth', 2) %plots susceptible graph
plot(t, Y(:,2), 'b', 'linewidth', 2) %plots exposed graph
plot(t, Y(:,3), 'r', 'linewidth', 2) %plots infected graph

legend('S_h','I_h','R_h', 'Location', 'best')
hold off

xlabel('Time in Weeks')
ylabel('Host Population')
title('Host SIR Dynamics')


subplot(1,2,2)
hold on
plot(t, Y(:,5), 'g', 'linewidth', 2) 
plot(t, Y(:,6), 'b', 'linewidth', 2)
plot(t, Y(:,7), 'r', 'linewidth', 2)
legend('S_v','E_v','I_v', 'Location', 'best')

xlabel('Time in Weeks')
ylabel('Vector Population')
title('Vector SEI Dynamics')

end
