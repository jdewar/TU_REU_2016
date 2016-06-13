function [] = chik_plot_both_newlyInfected(t,Y,data)
%plot_both plots number infected for model and real data
title('Real Infected Count and Model Infected Count');
xlabel('Time in weeks')
ylabel('population')
hold on
t1 = t'./7;
count = get_newly_infected_count(data);

model = Y(1:length(count),5);
model(2:end) = model(2:end)-model(1:end-1);

plot(t1(1:length(count)),count, '*');
plot(t1(1:length(count)),model, 'b')
legend('Real infected count','Model infected count')


end