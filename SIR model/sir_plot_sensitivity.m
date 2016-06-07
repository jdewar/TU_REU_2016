function [] = sir_plot_sensitivity(Q_fn, param_name, param_range, params)
 
    for i = 1:length(param_range) 
       params.(param_name) = param_range(i);
       q = Q_fn(params);
       y(i) = q;
    end
    
    plot(param_range,y);
    xlabel(strcat(param_name, ' value'));
    ylabel('time to 10% infected');
end

