function [] = plot_chik_model(t,Y)
%Plot_sir_model
%   takes time span, t, and solved sir matrix, Y, and graphs

subplot(1,2,1)
hold on
%plot(t, Y(:,1), 'g') %plots susceptible graph
plot(t, Y(:,2), 'b') %plots exposed graph
plot(t, Y(:,3), 'r') %plots infected graph
plot(t, Y(:,4), 'k')
plot(t, Y(:,5), 'm')
legend('exposed','infected','recovered', 'cumulative infected')
hold off

xlabel('time in weeks')
ylabel('human population')
title('human SEI dynamics')


subplot(1,2,2)
hold on
plot(t, Y(:,6), 'g') 
plot(t, Y(:,7), 'b')
plot(t, Y(:,8), 'r')
legend('susceptible','exposed','infected')

xlabel('time in weeks')
ylabel('mosquito population')
title('mosquito SEI dynamics')

end
