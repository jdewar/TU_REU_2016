function [] = plot_two_models(t1,Y1,t2,Y2,data)
%plot_both plots number infected for model and real data
title('Real Infected Count and Model Infected Count', 'fontsize', 18);
xlabel('Time in weeks', 'fontsize', 16)
ylabel('Population', 'fontsize', 16)
hold on
t1 = t1'./7;
plot(t1,(Y1(:,7) + Y1(:,8)), 'b')
t2 = t2'./7;
plot(t2,(Y2(:,7) + Y2(:,8)), 'r')
legend('Chikungunya infected count', 'Zika infected count', 'Location', 'best')


end