function [difference] = plot_chik_residual_newInfected(t,model,infected_real)

[val,difference1] = chik_cmp_newInfected(model, infected_real);
[val,difference2] = chik_real_model_cmp(model, infected_real);



t1 = t'./7;
subplot(1,2,1)
plot(t1(1:length(infected_real)),difference2, '*');
subplot(1,2,2)
plot(t1(1:length(infected_real)),difference1, '*');
title('Residual Graph')
xlabel('Time')
ylabel('Difference in Model and Real')

end