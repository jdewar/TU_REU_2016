function [ ] = chik_plot_data_infected(cumulative_count)
%plot_data plots real data
count = cumulative_count;
count(2:end) = cumulative_count(2:end) - cumulative_count(1:end-1);

% count_linear = cumulative_count_linear;
% count_linear(2:end) = cumulative_count_linear(2:end) - cumulative_count_linear(1:end-1);
hold on
title('Real Infected Count')
xlabel('Time in weeks')
ylabel('Population')
plot(count,'*')
% subplot(1,2,2)
% plot(count_linear,'o')

end