function [t,out] = chik_output(t_in, Y, param, options, functions)
 [t,out] = ode45(@(t,Y)chikungunya_rhs(t,Y,param, functions),t_in, Y, options);
 
end