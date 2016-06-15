function [] = chik_plot_obj_fn(param_array, data, array_names, t_in, functions, param_name, lb,ub)
n = 1;
for i = 1:length(array_names)
    if strcmp(param_name,array_names{i}) == 1
        n = i;
        break;
    end
end

for i = lb(n):ub(n)
    param_array(n) = i;
    param(i) = param_array(n);
    val(i) = chik_obj_fn(param_array, data, array_names, t_in, functions);
end

figure()
plot(param,val)
xlabel(strcat(param_name,' value'));
ylabel('objective function value');

end

