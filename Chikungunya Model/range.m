function [new_lb, new_ub ] = range(lb, ub, param_name, min, max, array_names)
new_lb = lb;
new_ub = ub;
for i = 1:length(array_names)
    if strcmp(array_names{i},param_name) == 1
        new_lb(i) = min;
        new_ub(i) = max;
    end
end

end

