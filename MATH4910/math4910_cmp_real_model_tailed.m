function [out, difference] = math4910_cmp_real_model_tailed(model, infected_real)
%CHIK_CMP_REAL_MODEL gets norm of difference

difference = model(1:length(infected_real),4) - infected_real';

flat = model(1:length(infected_real),4) - infected_real(1:end)';

out = sum((difference'.^2)) + sum((flat'.^2));

end