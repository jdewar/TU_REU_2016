function [ ] = chik_plot_NewlyInfected(t,new_count)
%chik_plot_data_infected plots newly infected

hold on
t1 = t'./7;
plot(t1(1:length(new_count)),new_count);

title('Newly Infected Count')
xlabel('Time in weeks')
ylabel('Population')


end