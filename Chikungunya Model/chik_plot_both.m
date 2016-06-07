function [] = chik_plot_both(t,Y,data)
%plot_both plots number infected for model and real data
title('Real Infected Count and Model Infected Count');
xlabel('Time in weeks')
ylabel('population')
hold on
t1 = t'./7;
plot(t1(1:length(data)),data, 'r');
plot(t1(1:length(data)),Y(1:length(data),5), 'b')
legend('Real infected count','Model infected count')


end
