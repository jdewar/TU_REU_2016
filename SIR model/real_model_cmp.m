function [out] = real_model_cmp(model, infected_real)
%real_model_cmp gets norm of difference
difference = model(:,4) - infected_real';
out = sum((difference'.^2));

end

