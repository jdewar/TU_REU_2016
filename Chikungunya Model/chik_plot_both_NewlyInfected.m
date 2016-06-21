function [ ] = chik_plot_both_NewlyInfected(t,Y,new_count)
%chik_plot_data_infected plots newly infected


hold on
t1 = t'./7;
plot(t1(1:length(new_count)),new_count, 'b');

title('Newly Infected Count')
xlabel('Time in weeks')
ylabel('Population')


end