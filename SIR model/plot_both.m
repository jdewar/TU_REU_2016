function [] = plot_both(t,Y,data)
%plot_both plots number infected for model and real data
title('Real Infected Count and Model Infected Count','fontsize',18);
xlabel('Time in Weeks','fontsize',16)
ylabel('Population','fontsize',16)
hold on
t1 = t';
plot(t1(1:length(data)),data, '*');
plot(t1(1:length(data)),Y(1:length(data),4), 'b')
legend('Real infected count','Model infected count')


end

