function [residual] = residual_calc (model,infected_real)

residual = model(1:length(infected_real),4) - infected_real'
end