function [ ] = chik_plot_data(count, tspan)
%plot_data plots real data
hold on
title('Real Infected Count')
xlabel('Time in weeks')
ylabel('Population')
plot(tspan./7, count,'*')
legend('Total cases')

end

