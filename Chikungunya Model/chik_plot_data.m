function [ ] = chik_plot_data(count, tspan)
%plot_data plots real data
hold on
title('Real Infected Count')
xlabel('Time in weeks')
ylabel('Population')

plot(tspan, count,'*')
legend('Total cases')

end

