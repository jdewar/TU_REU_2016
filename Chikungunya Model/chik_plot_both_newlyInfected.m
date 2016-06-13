function [] = chik_plot_both_newlyInfected(t,Y,data)
%plot_both plots number infected for model and real data
title('Real Infected Count and Model Infected Count');
xlabel('Time in weeks')
ylabel('population')
hold on
t1 = t'./7;
count = get_newly_infected_count(data);
plot(t1(1:length(count)),count, '*');
plot(t1(1:length(count)),Y(1:length(count),3), 'b')
legend('Real infected count','Model infected count')


end