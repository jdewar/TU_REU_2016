function [difference] = chik_real_model_cmp(model, infected_real)
%real_model_cmp gets norm of difference
difference = norm(model(1:length(infected_real),5) - infected_real');

end