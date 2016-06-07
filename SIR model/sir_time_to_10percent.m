function [time] = sir_time_to_10percent(params,total_pop, t_in,init)

    options = odeset('Events',@(t,Y)sir_10percent(t, Y,total_pop));
    fn = @(t,x)sir_rhs(t,x,params);
    [t,y,te,ye,ie] = ode45(fn,t_in, init, options);
    time = te;
    
end