function [out, difference] = cmp_real_model(model, infected_real)
%CHIK_CMP_REAL_MODEL returns sum squared difference of model and data

difference = model(1:length(infected_real'),7) + model(1:length(infected_real'),8)  - infected_real';

out = sum((difference.^2));

end