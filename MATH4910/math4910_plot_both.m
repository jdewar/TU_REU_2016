function [] = math4910_plot_both(t,Y,data)
%plot_both plots number infected for model and real data
title('Real Infected Count and Model Infected Count', 'fontsize', 18);
xlabel('Time in weeks', 'fontsize', 16)
ylabel('Population', 'fontsize', 16)
hold on
t1 = t'./7;
plot(t1(1:length(data)),data, '*');
plot(t1,Y(:,5), 'b')
legend('Real infected count','Model infected count', 'Location', 'best')


end
