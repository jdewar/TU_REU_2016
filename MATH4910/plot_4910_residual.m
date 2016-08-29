function [residual] = plot_chik_residual(t,model,infected_real)

residual = model(1:length(infected_real),5) - infected_real';

t1 = t'./7;
plot(t1(1:length(infected_real)),residual, '*');
title('Residual Graph')
xlabel('Time')
ylabel('Difference in Model and Real')

end