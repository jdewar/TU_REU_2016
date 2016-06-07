function [difference] = sir_sensitivity_analysis(t_in,init,params,param_name, total_pop) %#ok<*INUSL>
%sensativity analysis, respect to Beta
params.(param_name) = params.(param_name);

options = odeset('Events',@(t,Y)sir_10percentI(t, Y,total_pop));

epsilon = 0.001 * params.(param_name);
params1 = params;
params2 = params;

params1.(param_name) = params.(param_name) + epsilon;

fn = @(t,x)sir_rhs(t,x,params1);
[t,y,te1,ye1,ie1] = ode45(fn,t_in, init, options);

params2.(param_name) = params.(param_name) - epsilon;

fn = @(t,x)sir_rhs(t,x,params2);
[t,y,te2,ye2,ie2] = ode45(fn,t_in, init, options);

fn = @(t,x)sir_rhs(t,x,params);
[t,y,te3,ye3,ie3] = ode45(fn,t_in, init, options);

time = (te1-te2)/(2*epsilon);
difference = time * params.(param_name)/te3;

end

%in main sir_sensitivity_analysis([0:1:tend], init,param,'c', total_pop)