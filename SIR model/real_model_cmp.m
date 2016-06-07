function [difference] = real_model_cmp(model, infected_real)
%real_model_cmp gets norm of difference

difference = norm(model(1:length(infected_real),4) - infected_real');

end

