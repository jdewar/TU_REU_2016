function [out] = real_model_cmp(model, infected_real)
%real_model_cmp gets norm of difference
difference = model(:,4) - infected_real';
% flat = model(20:length(infected_real),4) - infected_real(20:end)';

out = sum((difference'.^2));% + sum((flat'.^2));

end

