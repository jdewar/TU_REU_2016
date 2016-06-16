function [] = sir_plot_obj_fn(param_array, data,params, array_names, t_in, total_pop, param_name, range)
n = 1;
for i = 1:length(array_names)
    if strcmp(param_name,array_names{i}) == 1
        n = i;
        break;
    end
end

for i = 1:length(range) 
    param_array(n) = range(i);
    param(i) = param_array(n);
    val(i) = sir_obj_fn(param_array, data,params, array_names, t_in, total_pop);
                       
end

plot((param),(val))
xlabel(strcat(param_name,'value'));
ylabel('objective function value');

end

