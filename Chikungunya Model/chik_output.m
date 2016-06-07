function [t,out] = chik_output(t_in, Y, param, options)

 [t,out] = ode45(@(t,Y)chikungunya_rhs(t,Y,param),t_in, Y, options);
 
end