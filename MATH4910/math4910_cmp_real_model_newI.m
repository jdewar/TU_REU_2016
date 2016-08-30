function [out, difference] = math4910_cmp_real_model_newI(model, infected_real)
%CHIK_CMP_REAL_MODEL returns sum squared difference of model and data
count = model(1:length(infected_real),5);
count(2:end) = count(2:end) - count(1:end-1);

difference = count - infected_real';

out = sum((difference.^2));

end