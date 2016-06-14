function [ ] = chik_plot_both_NewlyInfected(t,Y,new_count)
%chik_plot_data_infected plots newly infected

count_model = Y(:,5);
count_model(2:end) = count_model(2:end) - count_model(1:end-1);

hold on
t1 = t'./7;
plot(t1(1:length(new_count)),new_count, '*');
plot(t1(1:length(new_count)),count_model, 'b')


title('Newly Infected Count')
xlabel('Time in weeks')
ylabel('Population')


end