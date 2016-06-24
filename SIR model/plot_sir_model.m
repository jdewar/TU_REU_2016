function [] = plot_sir_model(t,Y)
%Plot_sir_model
%   takes time span, t, and solved sir matrix, Y, and graphs
title('SIR Model', 'fontsize', 18)
xlabel('Time in Weeks','fontsize', 16)
ylabel('Human Population', 'fontsize', 16)
hold on
plot(t, Y(:,1), 'k', 'LineWidth',2) %plots susceptible graph
plot(t, Y(:,2), '--','color','r','LineWidth',2) %plots infected graph
plot(t, Y(:,3), 'b', 'LineWidth',2) %plots recovered graph
% plot(t, Y(:,4), 'r', 'LineWidth',2) %plots cumu infected graph
legend('Susceptible','Infected','Recovered','Cumulative Infected', 'fontsize',12, 'Location','best')
end

