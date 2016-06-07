function [] = plot_sir_model(t,Y)
%Plot_sir_model
%   takes time span, t, and solved sir matrix, Y, and graphs
title('SIR model')
xlabel('time in weeks')
ylabel('human population')
hold on
plot(t, Y(:,1), 'g') %plots susceptible graph
plot(t, Y(:,2), 'b') %plots infected graph
plot(t, Y(:,3), 'r') %plots recovered graph
legend('susceptible','infected','recovered')
end

