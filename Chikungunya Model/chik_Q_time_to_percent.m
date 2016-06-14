function [time] = chik_Q_time_to_percent(params,total_infected, t_in,init, percent)
%CHIK_Q_TIME_TO_PERCENT ...
    options = odeset('Events',@(t,Y)chik_percent_ofI(t, Y,total_infected, percent));
    fn = @(t,x)chikungunya_rhs(t,x,params);
    [~,~,te] = ode45(fn,t_in, init, options);
    if numel(te) == 0
        time = NaN;
    else
        time = te;
    end
    
end

