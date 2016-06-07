function [ ] = plot_data(count)
%plot_data plots real data
hold on
title('Real Infected Count')
xlabel('Time in weeks')
ylabel('Population')
plot(count,'*')
legend('Total cases')

end

