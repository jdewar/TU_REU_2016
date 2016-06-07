function [t,out] = sir_output(t_in, Y, param, options)

 [t,out] = ode45(@(t,Y)sir_rhs(t,Y,param),t_in, Y, options);
 
end