function [time] = sir_time_to_percent(params,total_pop, t_in,init, percent)
%time to 10% infected
    options = odeset('Events',@(t,Y)sir_percentI(t, Y,total_pop, percent));
    fn = @(t,x)sir_rhs(t,x,params);
    [t,y,te,ye,ie] = ode45(fn,t_in, init, options);
    time = te;
    
end